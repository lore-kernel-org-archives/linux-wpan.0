Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:35445 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751971AbbEGHh5 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 7 May 2015 03:37:57 -0400
Received: by widdi4 with SMTP id di4so230862712wid.0
        for <linux-wpan@vger.kernel.org>; Thu, 07 May 2015 00:37:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <554A085D.9050509@fid4.com>
References: <CAG9Fz+vEia1W-hCnthVtWwoJzkHvdh2wm9uz9XxnCBLbxpLp+Q@mail.gmail.com>
	<20150506090821.GA1026@omega>
	<554A085D.9050509@fid4.com>
Date: Thu, 7 May 2015 09:37:56 +0200
Message-ID: <CAG9Fz+va2260ouM5DF0mdMq6PXvVNkN7abSzAh+CDLcrekL5Ug@mail.gmail.com>
Subject: Re: RPi, Raspbian with openlabs transceiver - lib/tool versions and
 updated instructions(?)
From: Christoffer Holmstedt <christoffer.holmstedt@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: "Michael C. Cambria" <mcc@fid4.com>
Cc: Alexander Aring <alex.aring@gmail.com>, linux-wpan@vger.kernel.org

2015-05-06 14:26 GMT+02:00 Michael C. Cambria <mcc@fid4.com>:
>
>
> On 05/06/2015 05:08 AM, Alexander Aring wrote:
>>
>> On Wed, May 06, 2015 at 09:27:39AM +0200, Christoffer Holmstedt wrote:
>>>
>>> I'm currently setting up my dev/test environment to get a "default"
>>> working state to build upon but have stumbled upon some issues on the
>>> way. I'm currently running Raspbian with latest bluetooth-next kernel.
>>> U-Boot from last november. For libnl I use the default packages
>>> available in Raspbian repository. wpan-tools I've checked out the 0.4
>>> release from git repository.
>>>
>>> U-Boot: 2014-11-10 [1]
>>> Raspbian version: 2015-02-16 (originally built with 3.18 kernel)
>>> Bluetooth-next kernel 4.1.0-rc1+ 2015-04-30 [2]
>>> libnl-3-dev version: 3.2.7-4 (Raspbian repository)
>>> libnl-genl-3-dev version: 3.2.7-4 (Raspbian repository)
>>> wpan-tools (tag: wpan-tools-0.4) [3]
>>>
>>> Is this set of libraries/tools ever going to work together or do I
>>> have an obvious mismatch that will for sure fail?
>>>
>>> ### command failed: Device or resource busy (-16)
>>
>> I think this is because raspbian has running the ifplug deamon (ifplugd)
>> which do an interface up if you want to do an interface down.
>>
>> Guenther documented this at [0]. Try to do a:
>>
>> kill $(ps awux | grep "[i]fplugd.*wpan0" | awk '{print $2}')
>>
>> into your shell. Then be sure that your interface is down before setting
>> the pan_id.
>
>
> I have been able to fix this at boot time by changing /etc/defaults/ifplugd
>
> From:
>
> INTERFACES="auto"
> HOTPLUG_INTERFACES="all"
>
> to:
>
> INTERFACES="eth0"
> HOTPLUG_INTERFACES="eth0"
>

Thank you all for the fast replies, I tried to bring the interface
down but didn't realize it was brought back up by ifplugd. I can
confirm that it was ifplugd problem and the solution from Michael
works perfectly, now I just need to add a bootup script to configure
the wpan0/lowpan0 interfaces after reboot.

Regards
-- 
Christoffer Holmstedt
