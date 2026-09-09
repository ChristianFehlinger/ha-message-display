# ha-message-display

I wanted a way for people at home to ping me while i am in the office.  
Not another phone notification, something sitting on the desk that i actually notice.  
I also wanted an excuse to play with e-ink, so i stuck a small Waveshare ESP32-S3 ePaper on my monitor and wired it into Home Assistant.

You pick a message on a dashboard ("dinner is ready", "call me", that kind of thing).  
The display shows it, a NeoPixel blinks, and it can beep.  
Hit the PWR button when you have seen it.

Sorry, my own setup is in German. For this repo I tried to change everything to English.

Board: [Waveshare ESP32-S3-ePaper-1.54G](https://www.waveshare.com/product/esp32-s3-epaper-1.54g.htm).  
Firmware is [ESPHome](https://esphome.io/).

## What it does

- Text on the e-paper comes from `input_select.epaper_message`
- LED on GPIO1 blinks in a colour per message (`red`, `green`, `blue`, `yellow`, `off`, `default`)
- Speaker can beep or stay quiet (`on`, `off`, `default`)
- Colour and sound live in one table in the HA automation — dashboard only has the message picker
- PWR button clears it

## Docs

Wiring and the components -> [docs/hardware.md](docs/hardware.md)  
Helpers, automation and dashboard -> [docs/home-assistant.md](docs/home-assistant.md)  

## Quick start

```bash
just secrets          # copies esphome/secrets.yaml.example
just install          # git hooks (whitespace, no private keys in commits)
```

Fill in `esphome/secrets.yaml`, then in ESPHome: add `esphome/message.yaml` → **Install** (wireless).

`just compile` builds the firmware if you have the ESPHome CLI.

### Home Assistant

See [docs/home-assistant.md](docs/home-assistant.md):

1. Helpers (`input_select`)
2. Automation `epaper_message_style` (central colour/sound table)
3. Lovelace dashboard (optional)

## Repository layout

```text
esphome/
  message.yaml           # Device firmware
  secrets.yaml.example   # Copy to secrets.yaml (gitignored)
homeassistant/
  helpers/input_select.yaml
  automations/epaper_message_style.yaml
  lovelace/dashboard-message.yaml
docs/
  hardware.md
  home-assistant.md
  img/
```

## Customisation

- New message text: add option to `input_select.epaper_message` and a line in the `style` table in the automation.
- Change colour/sound: edit `style` in `homeassistant/automations/epaper_message_style.yaml` only.
- LED count: `num_leds` in `esphome/message.yaml` (37 = NeoHEX, 1 = single LED)

