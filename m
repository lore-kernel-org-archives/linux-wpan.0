Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:45793 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752610AbbAYLgI (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sun, 25 Jan 2015 06:36:08 -0500
Received: by mail-wi0-f181.google.com with SMTP id fb4so4900314wid.2
        for <linux-wpan@vger.kernel.org>; Sun, 25 Jan 2015 03:36:07 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20150123075902.GA11163@omega>
References: <CAAkG1NOO3ScSHG7x+LgU6Min8OP-vcihwXwmLH7JSzGeVw8tyQ@mail.gmail.com>
	<20150120194407.GB18226@omega>
	<CAAkG1NNuA0vp1A6brVbHw0Co1qL5rAVCPBT=+t+cBZULveBhiw@mail.gmail.com>
	<CAFUtXGw2_+6CCX69RKxv0BueCx5mhddBt3k7yDXzoHcF-r9+Pw@mail.gmail.com>
	<54bf9983.07f4440a.7103.0a2e@mx.google.com>
	<20150121154634.GA664@omega>
	<CAAkG1NNNTLaH0TgEupLm3yVEU6wwXPBR38mpMrPfb-bu7wUAPg@mail.gmail.com>
	<20150122205920.GA18612@omega>
	<CAFUtXGwkG7p-LLjRdV5fKrCLQMMVJzMDqBtG4Dt148xAKAm-XQ@mail.gmail.com>
	<20150122222013.GB18612@omega>
	<20150123075902.GA11163@omega>
Date: Sun, 25 Jan 2015 12:36:06 +0100
Message-ID: <CAFUtXGxTKk-vNM_1Zh6cTCqSNuqBaT1aTMWYAV2pwvbqxi_+yA@mail.gmail.com>
Subject: Re: Device or resource busy
From: Maciej Wasilak <wasilak@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: Rohit Kulkarni <rmkulkar@gmail.com>, linux-wpan@vger.kernel.org

Hello,

2015-01-23 8:59 GMT+01:00 Alexander Aring <alex.aring@gmail.com>:
>> Do you are sure that there is no daemon running or something else which
>> automatically ifup the interface again if you want to set it down? Maybe
>> just mv the /etc/$NETWORKING_STUFF into a separate directory and try again.

After your pointers I've found the answer on one of the forums - the
problem is caused by ifplugd service, which automatically brings up
wpan0 interface after it is brought down.
It seems that in previous branch (linux-wpan-next) this problem didn't
exist, because wpan0 interface had to be manually created (and ifplugd
didn't mess with it).

Solution 1 (blunt): killall ifplugd

Solution 2: edit /etc/default/ifplugd

My working /etc/default/ifplugd below:
____

# This file may be changed either manually or by running dpkg-reconfigure.
#
# N.B.: dpkg-reconfigure deletes everything from this file except for
# the assignments to variables INTERFACES, HOTPLUG_INTERFACES, ARGS and
# SUSPEND_ACTION.  When run it uses the current values of those variables
# as their default values, thus preserving the administrator's changes.
#
# This file is sourced by both the init script /etc/init.d/ifplugd and
# the udev script /lib/udev/ifplugd.agent to give default values.
# The init script starts ifplugd for all interfaces listed in
# INTERFACES, and the udev script starts ifplugd for all interfaces
# listed in HOTPLUG_INTERFACES. The special value all starts one
# ifplugd for all interfaces being present.
INTERFACES="eth0"
HOTPLUG_INTERFACES="eth0"
ARGS="-q -f -u0 -d10 -w -I"
SUSPEND_ACTION="stop"

Thank you very much for your help!!!

Regards
Maciek
