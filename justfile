default:
    @just --list --unsorted

# Install git hooks
install:
    pre-commit install

# Compile firmware (needs ESPHome CLI). Always uses the repo root, not your current folder.
compile:
    esphome compile "{{ justfile_directory() }}/esphome/message.yaml"
