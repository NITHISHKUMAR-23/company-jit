#include <stdio.h>
#include <yaml.h>
#include <string.h>

// Function to read and parse YAML data
void parse_yaml(const char *file_path) {
    FILE *file = fopen(file_path, "r");
    if (!file) {
        fprintf(stderr, "Failed to open file: %s\n", file_path);
        return;
    }

    yaml_parser_t parser;
    yaml_event_t event;

    // Initialize the YAML parser
    if (!yaml_parser_initialize(&parser)) {
        fprintf(stderr, "Failed to initialize parser!\n");
        fclose(file);
        return;
    }
    yaml_parser_set_input_file(&parser, file);

    int in_bit11_8 = 0, in_target_key = 0;
    const char *target_key = "0000";
    const char *bit11_8_key = "bit11-8";

    while (1) {
        if (!yaml_parser_parse(&parser, &event)) {
            fprintf(stderr, "Parser error %d\n", parser.error);
            break;
        }

        if (event.type == YAML_SCALAR_EVENT) {
            const char *value = (const char *)event.data.scalar.value;

            if (in_bit11_8 && strcmp(value, target_key) == 0) {
                // Print the corresponding value of "0000" in "bit11-8"
                yaml_parser_parse(&parser, &event);
                if (event.type == YAML_SCALAR_EVENT) {
                    printf("Value for bit11-8['%s']: %s\n", target_key, event.data.scalar.value);
                }
                yaml_event_delete(&event);
                break;
            }

            if (strcmp(value, bit11_8_key) == 0) {
                in_bit11_8 = 1;
            } else {
                in_bit11_8 = 0;
            }
        }

        if (event.type == YAML_STREAM_END_EVENT) {
            break;
        }

        yaml_event_delete(&event);
    }

    yaml_parser_delete(&parser);
    fclose(file);
}

int main() {
    const char *yaml_file = "D:/Project_Command_Parsing/YAML/Python/example.yaml";
    parse_yaml(yaml_file);
    return 0;
}
