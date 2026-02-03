# wl-clipboard.yazi

Forked from: [orhnk/system-clipboard.yazi](https://github.com/orhnk/system-clipboard.yazi) to work with wayland compositors.

## Demo

<https://github.com/user-attachments/assets/74d59f49-266a-497e-b67e-d77e64209026>

## Config

> [!NOTE]
> You need yazi 3.x for this plugin to work.

> [!Important]
> This plugin utilizes ["wl-clipboard" project](https://github.com/bugaevc/wl-clipboard).
> You need to have it installed on your system. (Make sure that It's on your $PATH)

## Installation

```bash
ya pkg add grappas/wl-clipboard
```

## Configuration

Copy or install this plugin and add the following keymap to your `manager.prepend_keymap`:

```toml
on = "<C-y>"
run = ["plugin wl-clipboard"]
```

> [!Tip]
> If you want to use this plugin with yazi's default yanking behaviour you should use `cx.yanked` instead of `tab.selected` in `init.lua` (See [#1487](https://github.com/sxyazi/yazi/issues/1487))
