Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:36462 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751328AbbEFJIc (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 6 May 2015 05:08:32 -0400
Received: by wizk4 with SMTP id k4so193781389wiz.1
        for <linux-wpan@vger.kernel.org>; Wed, 06 May 2015 02:08:31 -0700 (PDT)
Date: Wed, 6 May 2015 11:08:25 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: RPi, Raspbian with openlabs transceiver - lib/tool versions and
 updated instructions(?)
Message-ID: <20150506090821.GA1026@omega>
References: <CAG9Fz+vEia1W-hCnthVtWwoJzkHvdh2wm9uz9XxnCBLbxpLp+Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAG9Fz+vEia1W-hCnthVtWwoJzkHvdh2wm9uz9XxnCBLbxpLp+Q@mail.gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Christoffer Holmstedt <christoffer.holmstedt@gmail.com>
Cc: linux-wpan@vger.kernel.org

On Wed, May 06, 2015 at 09:27:39AM +0200, Christoffer Holmstedt wrote:
> I'm currently setting up my dev/test environment to get a "default"
> working state to build upon but have stumbled upon some issues on the
> way. I'm currently running Raspbian with latest bluetooth-next kernel.
> U-Boot from last november. For libnl I use the default packages
> available in Raspbian repository. wpan-tools I've checked out the 0.4
> release from git repository.
> 
> U-Boot: 2014-11-10 [1]
> Raspbian version: 2015-02-16 (originally built with 3.18 kernel)
> Bluetooth-next kernel 4.1.0-rc1+ 2015-04-30 [2]
> libnl-3-dev version: 3.2.7-4 (Raspbian repository)
> libnl-genl-3-dev version: 3.2.7-4 (Raspbian repository)
> wpan-tools (tag: wpan-tools-0.4) [3]
> 
> Is this set of libraries/tools ever going to work together or do I
> have an obvious mismatch that will for sure fail?
> 
> ### command failed: Device or resource busy (-16)

I think this is because raspbian has running the ifplug deamon (ifplugd)
which do an interface up if you want to do an interface down.

Guenther documented this at [0]. Try to do a:

kill $(ps awux | grep "[i]fplugd.*wpan0" | awk '{print $2}')

into your shell. Then be sure that your interface is down before setting
the pan_id.

Also I saw you have two interfaces and the wpan0 smells like the
fakelb(because zero mac address), I currently don't trust the fakelb
transceiver. It's a poor driver which should be updated. So in your case
you should use the wpan1 interface or remove the fakelb module by
putting this module in your blacklist.


more background about interface up and address settings:

The reason why we doesn't allow this is because if the interface is up
and we allow to change the address filter settings in this situation the
locking mechanism is a lot of complicated while parsing the frame. To
avoid that we simple say "it's a readonly variable when parsing the
frame can be occur". The conclusion is we don't need any locking of this
variable in a very "strong" context while parsing the frame. If the
interface is down, the rtnl mutex is enough to protect this variable.

The address filter will be filled when an interface up occurs again then.

- Alex

[0] https://honk.sigxcpu.org/piki/hw/rpi6lowpan/

