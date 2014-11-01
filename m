Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:57443 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752950AbaKAT1r (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sat, 1 Nov 2014 15:27:47 -0400
Received: by mail-wi0-f170.google.com with SMTP id q5so3440423wiv.1
        for <linux-wpan@vger.kernel.org>; Sat, 01 Nov 2014 12:27:45 -0700 (PDT)
Date: Sat, 1 Nov 2014 20:27:43 +0100
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [Linux-zigbee-devel] Cannot get MRFs talking. Not sure what I've
 done wrong.
Message-ID: <20141101192740.GC31204@omega>
References: <01C25E88-7F4B-4669-9BB6-AED08C4B66EE@elephantheadsoft.com>
 <20141101084719.GA31204@omega>
 <A4A370F0-05B7-4FCC-83BA-2633D54680E0@elephantheadsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <A4A370F0-05B7-4FCC-83BA-2633D54680E0@elephantheadsoft.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: "Dr. Aditya Nagrath PhD" <anagrath@elephantheadsoft.com>
Cc: linux-zigbee-devel@lists.sourceforge.net, linux-wpan@vger.kernel.org

On Sat, Nov 01, 2014 at 10:40:39AM -0600, Dr. Aditya Nagrath PhD wrote:
> Hi,
> 
> Apologize for leaving out version information.  
> I am using kernel:
> Linux beaglebone 3.8.13-bone50 #1 SMP Tue May 13 13:24:52 UTC 2014 armv7l GNU/Linux
> 

can you try to use bleeding edge kernel? [0]

> 
> I had to compile the libn1 and tools to get this far since there was a crash in iz add.  These are the versions that I downloaded and compiled.
> drwxr-xr-x 11 debian admin 4096 Oct 28  2014 libnl-3.2.25
> drwxr-xr-x 11 debian admin 4096 Oct 28  2014 lowpan-tools-0.3.1
> 

this looks fine.

> and just to confirm that they updated:
> root@beaglebone:~# iz --version
> iz: /lib/arm-linux-gnueabihf/libnl-genl-3.so.200: no version information available (required by iz)
> iz: /lib/arm-linux-gnueabihf/libnl-3.so.200: no version information available (required by iz)

mhhh, I didn't get such warning.

> iz 0.3.1
> 
> Appreciate your help Alex.  Right now I’m under water as well so I understand your pain.  Let me know if I can help in anyway
> 

Just try a bleeding edge kernel and try again. Then we can see what's
going on there. Also set a eui-64 address (extended address) before
running "iz set". You can do that by "ip link set $WPAN_INTERFACE address $EXTENDED_ADDR".

exmaples for variables:

WPAN_INTERFACE="wpan0"
EXTENDED_ADDR="aa:aa:aa:aa:aa:aa:aa:aa"

Please do these steps while $WPAN_INTERFACE is down.

- Alex

[0] http://git.kernel.org/cgit/linux/kernel/git/bluetooth/bluetooth-next.git
