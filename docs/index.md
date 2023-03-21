---
# Feel free to add content and custom Front Matter to this file.
# To modify the layout, see https://jekyllrb.com/docs/themes/#overriding-theme-defaults

layout: home
# layout: page
nav_order: 1
permalink: /
title: Home
---

# The HDI Way of Working

## Introduction

This evolving framework will describe a consistent, high-quality approach to Data and Software Engineering at Health Data Insight.

It is an opinionated approach intending to support rapid development, across numerous projects, by a fungible workforce who can swap between assignments with the minimum friction.

It builds on the [twelve-factor app](https://12factor.net) methodology and is intended to be compatible with the [NHS Digital Software Engineering Quality Framework](https://github.com/NHSDigital/software-engineering-quality-framework) and other frameworks like [the GDS Way](https://gds-way.cloudapps.digital).

The most significant difference is that we will be opinionated and make technological and process choices. Everyone is encouraged to discuss and submit Pull Requests (PRs) if they want changes to the choices made, but by making those choices, we can automate many tedious background tasks that are currently manual.

## Installation

HDI Way of Working can be installed at the command line on any machine with Ruby installed.

If you have a Ruby based project, using Bundler to manage dependencies, then install the gem and add to the application's Gemfile by executing:

    bundle add way_of_working

Otherwise install the gem by executing:

    gem install way_of_working
