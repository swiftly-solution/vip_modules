<p align="center">
  <a href="https://github.com/swiftly-solution/vip_modules">
    <img src="https://cdn.swiftlycs2.net/swiftly-logo.png" alt="SwiftlyLogo" width="80" height="80">
  </a>

  <h3 align="center">[VIP] Chat</h3>

  <p align="center">
    A module for <a href="https://github.com/swiftly-solution/vip-core">Swiftly VIP Core</a> that adds prefix & colors in chat to VIP Players.
    <br/>
  </p>
</p>

---
### Dependencies 📃

- [Swiftly VIP Core Plugin](https://github.com/swiftly-solution/vip-core)

## Installation
1. Perform a drag-and-drop installation.
2. Add `chat`, `chattag`, `chattagcolor`, `chatnamecolor`, `chattextcolor` to the desired VIP Group in `addons/swiftly/configs/plugins/vips.json`.
### Example:
```json
	"groups": [
		{
			"id": "yourvip",
			"display_name": "VIP Group",
			"features": {
				"chattag": "[VIP Group]", // The prefix that your VIP Players will have.
				"chattagcolor": "{darkred}", // The color for the prefix that your VIP Players will have.
				"chatnamecolor": "{default}", // The color for the name of your VIP Players.
				"chattextcolor": "{default}"  // The color for the text of your VIP Players (put , if you need to).
			}
		}
	],
```
3. Reload the configuration of the VIP by using `sw_adminvip`.

### Creating A Pull Request 😃

1. Fork the Project
2. Create your Feature Branch
3. Commit your Changes
4. Push to the Branch
5. Open a Pull Request

### Have ideas/Found bugs? 💡
Join [Swiftly Discord Server](https://swiftlycs2.net/discord) and send a message in the topic from `📕╎ plugins-sharing` named `[VIP] Modules`!


---