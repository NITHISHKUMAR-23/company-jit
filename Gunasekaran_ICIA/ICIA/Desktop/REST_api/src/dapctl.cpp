#include <dapctl.h>

#include <asio.hpp>

#include <iostream>
#include <sstream>
#include <string>

using asio::ip::tcp;

static void basic_log(const char* function, const std::string message)
{
    std::cerr << "[dapctl_tcp:" << function << "] " << message << "\n";
}

#define LOG(LOGMSG) basic_log(__FUNCTION__, LOGMSG)

struct dapctl {
    dapctl(std::string ip, std::string port)
        : m_ip(ip)
        , m_port(port)
        , m_socket(m_io_context)
        , m_resolver(m_io_context)
    {
    }

    bool write_msg(const void* data, int32_t size)
    {
        asio::error_code error;

        // Send size
        m_socket.write_some(asio::buffer(&size, sizeof(size)), error);
        if (error == asio::error::eof) {
            m_connected = false;  // Connection closed cleanly by peer.
            return false;
        } else if (error) {
            m_connected = false;
            return false;
        }

        // Send payload
        m_socket.write_some(asio::buffer(data, size), error);
        if (error == asio::error::eof) {
            m_connected = false;  // Connection closed cleanly by peer.
            return false;
        } else if (error) {
            m_connected = false;
            return false;
        }

        return true;
    }

    bool read_msg(void* data, int32_t* size)
    {
        asio::error_code error;

        // Receive size
        m_socket.read_some(asio::buffer(size, sizeof(*size)), error);
        if (error == asio::error::eof) {
            m_connected = false;  // Connection closed cleanly by peer.
            return false;
        } else if (error) {
            m_connected = false;
            return false;
        }

        // Receive payload
        m_socket.read_some(asio::buffer(data, *size), error);
        if (error == asio::error::eof) {
            m_connected = false;  // Connection closed cleanly by peer.
            return false;
        } else if (error) {
            m_connected = false;
            return false;
        }

        return true;
    }

    bool connected() { return m_connected; }

    bool connect()
    {
        try {
            asio::connect(m_socket, m_resolver.resolve(m_ip, m_port));
            LOG("Connected to DAP");
            m_connected = true;
            return true;
        } catch (const std::exception& e) {
            LOG(e.what());
            return false;
        }
    }

private:
    std::string m_ip;
    std::string m_port;

    bool m_connected = false;

    asio::io_context m_io_context;
    tcp::socket m_socket;
    tcp::resolver m_resolver;
};

dapctl_status dapctl_open(dapctl** ptr, const char* uri)
{
    LOG(uri);

    std::string ip;
    std::string port;

    std::istringstream f(uri);
    if (!std::getline(f, ip, ':')) {
        LOG("Failed to get ip");
        return DAPCTL_STATUS_FAILED;
    }

    f >> port;

    if (port == "") {
        LOG("Failed to get port");
        return DAPCTL_STATUS_FAILED;
    }

    auto* me = new dapctl(ip, port);

    // try to make a first connection
    me->connect();

    *ptr = me;

    return DAPCTL_STATUS_SUCCESS;
}

dapctl_status dapctl_close(dapctl* handle)
{
    delete handle;
    return DAPCTL_STATUS_SUCCESS;
}

dapctl_status dapctl_dispatch_message(dapctl* handle,
                                      void* payload,
                                      int32_t* size)

{
    // If the connection is not open, try to reconnect.
    if (!handle->connected()) {
        if (!handle->connect()) {
            LOG("Can't connect to DAP");
            return DAPCTL_STATUS_OFF_LINE;
        }
    }

    // Send message
    if (!handle->write_msg(payload, *size)) {
        return DAPCTL_STATUS_FAILED;
    }

    // Get response
    if (!handle->read_msg(payload, size)) {
        return DAPCTL_STATUS_FAILED;
    }

    return DAPCTL_STATUS_SUCCESS;
}
