---
layout: page
---

# README Badges

Badges at the top of a project's README file are a powerful tool for providing immediate, concise, and easily digestible information about a project.

They are an important feature, as they communicate crucial insights such as the build status, test coverage, package version, licensing information, or even the platform compatibility of the project, all at a glance. Badges allow developers to quickly gauge the project's health, and maintenance level, without delving into the project's codebase or documentation.

Moreover, badges can help foster a sense of openness and reliability within the open-source community, as they provide a transparent snapshot of the project's current state. This makes them essential to building trust and confidence in a project, which can facilitate broader adoption and community involvement.

Our badge "panel" is a pair of predefined HTML comments that top and tail Way of Working badges in the README, so that other generators within the framework can automatically find the panel and add their badge(s) to it.

[![HDI Way of Working](https://img.shields.io/badge/HDI-Way%20of%20Working-8169e3?labelColor=000)](https://healthdatainsight.github.io/way_of_working/)

We have created a Way of Working badge to identify at a glance that a project has adopted the Way of Working in some way.

## Usage

To add the badge "panel" and Way of Working badge to your project, use the following at the command line:

    way_of_working init readme_badge
