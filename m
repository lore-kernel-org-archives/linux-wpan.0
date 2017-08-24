Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from ec2-52-27-115-49.us-west-2.compute.amazonaws.com ([52.27.115.49]:46796
        "EHLO osg.samsung.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752634AbdHXNyP (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Thu, 24 Aug 2017 09:54:15 -0400
Received: from localhost (localhost [127.0.0.1])
        by osg.samsung.com (Postfix) with ESMTP id 7A820A0C9D
        for <linux-wpan@vger.kernel.org>; Thu, 24 Aug 2017 13:54:43 +0000 (UTC)
Received: from osg.samsung.com ([127.0.0.1])
        by localhost (s-opensource.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id DuuQuWsxUpIH for <linux-wpan@vger.kernel.org>;
        Thu, 24 Aug 2017 13:54:42 +0000 (UTC)
Received: from [192.168.2.112] (pD9F79285.dip0.t-ipconnect.de [217.247.146.133])
        by osg.samsung.com (Postfix) with ESMTPSA id 8406DA05F0
        for <linux-wpan@vger.kernel.org>; Thu, 24 Aug 2017 13:54:42 +0000 (UTC)
Subject: Re: AT86RF212 based USB-Stick (HUL)
References: <5179358.aL3rf9WXy9@hella-laptop>
 <29470889.B3lc1jFHDt@hella-laptop>
 <79f111e5-5c1e-78d6-c1c8-b6598492fa2e@osg.samsung.com>
 <751534928.IoX8EvYzkW@hella-laptop>
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <70c02600-bb4e-7cad-f295-cc692d107f2c@osg.samsung.com>
Date: Thu, 24 Aug 2017 15:54:11 +0200
MIME-Version: 1.0
In-Reply-To: <751534928.IoX8EvYzkW@hella-laptop>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org

Hello.

On 08/18/2017 12:26 PM, Josef Filzmaier wrote:
> Hi!
> 
> I did refactor both repositories. I think they should now be much more
> enjoyable to review ;) - I would however like you to have another quick look
> within my github repo before i git send-mail it to the mailing list.

Will do that in a moment.

> I rebased the patch of the linux driver to the 4.13-rc5 source code so it
> should be much easier to mainline. It is only a single commit, i was not sure
> how i should separate the commits without having "dead code". I think the
> patch is small enough that one commit is still feasible. [1]

It looks ok to be in one commit. It also applies cleanly on net-next 
which I use for testing.

> I did separate the firmware into two commits: One that enables debugging
> and one that introduces the new board (with refactoring). [2]

Good.

> The changes were tested again on the raspberry pi with linux 4.13-rc5 and
> both patches applied (Firmware and Kernel).

I did some testing now and so far it all looks good. The combinations I 
tested so far are:
1) ATUSB mainline driver + firmware with your patch
2) ATUSB driver with your patch + mainline firmware version
3) ATUSB driver with your patch + firmware with your patch

No problems spotted so far. Good job! :)

I still need to dig out my rzusb hardware and test it there as well.

> Today i finally sent you the Busware HUL dongle, so you should receive it
> sometime next week.

It arrived, thanks a lot. How would I go about flashing it? I build the 
firmware already but I'm a bit unsure how the flashing would go. Do I 
need JTAG or SPI or can it be done with the Atmel DFU variant (I think 
the tool is called dfu-programmer)?

What would be the commandline for the flashing? Would be nice if we 
could document that for others.

regards
Stefan Schmidt
