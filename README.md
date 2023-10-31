<p align="center">
	<img width="256px" src="https://github.com/GodotParadise/Achievements/blob/main/icon.jpg" alt="GodotParadiseAchievements logo" />
	<h1 align="center">Godot Paradise Achievements</h1>
	
[![LastCommit](https://img.shields.io/github/last-commit/GodotParadise/Achievements?cacheSeconds=600)](https://github.com/GodotParadise/Achievements/commits)
[![Stars](https://img.shields.io/github/stars/godotparadise/Achievements)](https://github.com/GodotParadise/Achievements/stargazers)
[![Total downloads](https://img.shields.io/github/downloads/GodotParadise/Achievements/total.svg?label=Downloads&logo=github&cacheSeconds=600)](https://github.com/GodotParadise/Achievements/releases)
[![License](https://img.shields.io/github/license/GodotParadise/Achievements?cacheSeconds=2592000)](https://github.com/GodotParadise/Achievements/blob/main/LICENSE.md)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=flat&logo=github)](https://github.com/godotparadise/Achievements/pulls)
[![](https://img.shields.io/discord/1167079890391138406.svg?label=&logo=discord&logoColor=ffffff&color=7389D8&labelColor=6A7EC2)](https://discord.gg/XqS7C34x)
[![Kofi](https://badgen.net/badge/icon/kofi?icon=kofi&label)](https://ko-fi.com/bananaholograma)
</p>

[![es](https://img.shields.io/badge/lang-es-yellow.svg)](https://github.com/GodotParadise/Achievements/blob/main/locale/README.es-ES.md)

- - -

Implement achievements in your game in a simple way and with minimal security practices.

- [Requirements](#requirements)
- [✨Installation](#installation)
	- [Automatic (Recommended)](#automatic-recommended)
	- [Manual](#manual)
	- [CSharp version](#csharp-version)
- [Getting started](#getting-started)
- [Ready](#ready)
- [Achievement structure](#achievement-structure)
- [Accessible variables](#accessible-variables)
- [Functions](#functions)
	- [get\_achievement(name: String) -\> Dictionary](#get_achievementname-string---dictionary)
	- [update\_achievement(name: String, data: Dictionary)](#update_achievementname-string-data-dictionary)
	- [unlock\_achievement(name: String)](#unlock_achievementname-string)
	- [reset\_achievement(name: String, data: Dictionary = {})](#reset_achievementname-string-data-dictionary--)
- [Signals](#signals)
- [✌️You are welcome to](#️you-are-welcome-to)
- [🤝Contribution guidelines](#contribution-guidelines)
- [📇Contact us](#contact-us)


# Requirements
📢 We don't currently give support to Godot 3+ as we focus on future stable versions from version 4 onwards
* Godot 4+

# ✨Installation
## Automatic (Recommended)
You can download this plugin from the official [Godot asset library](https://godotengine.org/asset-library/asset/2039) using the AssetLib tab in your godot editor. Once installed, you're ready to get started
##  Manual 
To manually install the plugin, create an **"addons"** folder at the root of your Godot project and then download the contents from the **"addons"** folder of this repository
## CSharp version
This plugin has also been written in CSHarp, you can find it on [Achievements-CSharp](https://github.com/GodotParadise/Achievements-CSharp)


# Getting started
You can access this functionality using the class `GodotParadiseAchievements` where you can interact with your source file.

Before start you need to set few project settings that will be available after load the plugin:
![achievements-config](https://github.com/GodotParadise/Achievements/blob/main/images/achievements_config.png)

**Local source** refers to the path of the local file that contains the achievements template. This file is read-only and is used solely to define the structure of the achievements in your game. For example: `res://settings/achievements.json`

**Remote source** on the other hand, refers to the path of the remote JSON file that also holds the achievements template. The same rules apply as for the local source, but this information is obtained from a remote URL. For example: `https://myserver/achievements.json`

**Save directory** is the location where the encrypted saved file, used to track achievement progress, will be created on the player's machine. By default, it utilizes `OS.get_user_data_dir()/[project_name]`

**Save file name** is the name of the encrypted file that tracks achievement progress. By default, it is named `achievements.json`

**Password** is the character set used for encrypting and decrypting the saved achievements file. By default, it generates a random string with a length of 25 characters. This length should be sufficient for most use cases, ensuring that players cannot alter their achievement progress accessing the file.

# Ready
When this node becomes ready, it performs several actions:
1. It connects itself to the `achievement_updated` signal, which updates the encrypted file and checks if all achievements have been unlocked. If all achievements are unlocked, it emits the `all_achievements_unlocked` signal.
2. It creates the save directory using the path defined in **ProjectSettings**.
3. It prepares the achievements within the class by reading from the sources defined in **ProjectSettings**
4. Sync the latest achievements update from the encrypted saved file if it exists

# Achievement structure
The JSON file **must adhere to a specific structure** in order to function correctly. While you can include additional custom properties tailored to your game, there are mandatory ones that must be present:

```json
{
    "achievement-name": {
        "name": "MY achievement",
        "description": "Kill 25 enemies",
        "is_secret": false,
        "count_goal": 25,
        "current_progress": 0.0,
        "icon_path": "res://assets/icon/my-achievement.png",
        "unlocked": false,
        "active": true
    }
}
```
It's important to note that not all achievements will have a `count_goal` requirement for unlocking progress. In cases where this requirement is not applicable, you should leave the `count_goal` value as zero. **The logic and conditions for unlocking achievements are entirely determined by your game project.**
This class serves as a helper for updating and unlocking achievements while emitting the appropriate signals for interaction.

# Accessible variables
- current_achievements: Dictionary = {}
- unlocked_achievements: Dictionary = {}
- achievements_keys: PackedStringArray = []

# Functions
## get_achievement(name: String) -> Dictionary
Retrieve the information from the desired achievement, if the name does not exist as key it will return an empty dictionary.

`GodotEssentialsAchievements.get_achievement("orcs_party")`

## update_achievement(name: String, data: Dictionary)
This function updates the properties of the selected achievement, with values from the data dictionary overriding the existing ones. This action also emits the `achievement_updated` signal.

`GodotEssentialsAchievements.update_achievement("orcs_party", {"current_progress": 0.55})`

## unlock_achievement(name: String)
If the achievement was not previously unlocked, this function changes the `unlocked` variable to true and emits the `achievement_unlocked` signal. This action directly unlocks the achievement without further checks.

`GodotEssentialsAchievements.unlock_achievement("orcs_party")`

## reset_achievement(name: String, data: Dictionary = {})
Reset the achievement to a previous state. The `current_progress` and `unlocked` will be set to 0 and false respectively. You can pass as second parameter the data you want to update in this process.
This action also emits the `achievement_reset` and `achievement_updated` signals.

`GodotEssentialsAchievements.reset_achievement("orcs_party", {"description": "An orc party was discovered"})`

# Signals
- *achievement_unlocked(name: String, achievement: Dictionary)*
- *achievement_updated(name: String, achievement: Dictionary)* 
- *achievement_reset(name: String, achievement: Dictionary)*
- *all_achievements_unlocked*

# ✌️You are welcome to
- [Give feedback](https://github.com/GodotParadise/Achievements/pulls)
- [Suggest improvements](https://github.com/GodotParadise/Achievements/issues/new?assignees=BananaHolograma&labels=enhancement&template=feature_request.md&title=)
- [Bug report](https://github.com/GodotParadise/Achievements/issues/new?assignees=BananaHolograma&labels=bug%2C+task&template=bug_report.md&title=)

GodotParadise is available for free.

If you're grateful for what we're doing, please consider a donation. Developing GodotParadise requires massive amount of time and knowledge, especially when it comes to Godot. Even $1 is highly appreciated and shows that you care. Thank you!

- - -
# 🤝Contribution guidelines
**Thank you for your interest in Godot Paradise!**

To ensure a smooth and collaborative contribution process, please review our [contribution guidelines](https://github.com/GodotParadise/Achievements/blob/main/CONTRIBUTING.md) before getting started. These guidelines outline the standards and expectations we uphold in this project.

**📓Code of Conduct:** We strictly adhere to the [Godot code of conduct](https://godotengine.org/code-of-conduct/) in this project. As a contributor, it is important to respect and follow this code to maintain a positive and inclusive community.

- - -

# 📇Contact us
If you have built a project, demo, script or example with this plugin let us know and we can publish it here in the repository to help us to improve and to know that what we do is useful.
