Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from ec2-52-27-115-49.us-west-2.compute.amazonaws.com ([52.27.115.49]:50216
        "EHLO osg.samsung.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753006AbdHQLmM (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Thu, 17 Aug 2017 07:42:12 -0400
Received: from localhost (localhost [127.0.0.1])
        by osg.samsung.com (Postfix) with ESMTP id A7123A0CAD
        for <linux-wpan@vger.kernel.org>; Thu, 17 Aug 2017 11:42:39 +0000 (UTC)
Received: from osg.samsung.com ([127.0.0.1])
        by localhost (s-opensource.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id rJNZiZhtTeg2 for <linux-wpan@vger.kernel.org>;
        Thu, 17 Aug 2017 11:42:39 +0000 (UTC)
Received: from [192.168.2.112] (pD9F79285.dip0.t-ipconnect.de [217.247.146.133])
        by osg.samsung.com (Postfix) with ESMTPSA id AC978A05EE
        for <linux-wpan@vger.kernel.org>; Thu, 17 Aug 2017 11:42:38 +0000 (UTC)
Subject: Re: AT86RF212 based USB-Stick (HUL)
References: <5179358.aL3rf9WXy9@hella-laptop>
 <1551752.M6fFiAEvOh@hella-laptop>
 <17366136-0ab6-99ea-89e4-916938a0ed17@osg.samsung.com>
 <29470889.B3lc1jFHDt@hella-laptop>
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <79f111e5-5c1e-78d6-c1c8-b6598492fa2e@osg.samsung.com>
Date: Thu, 17 Aug 2017 13:42:08 +0200
MIME-Version: 1.0
In-Reply-To: <29470889.B3lc1jFHDt@hella-laptop>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org

Hello.

On 08/17/2017 01:14 PM, Josef Filzmaier wrote:
> Hello!
> 
> First i want to thank you for taking your time to look at my code and all the
> useful comments. I will go through them step by step.

No problem. I'm very happy to see someone working on adding support for 
a new board to the firmware and driver. Glad to review and test it. 
Sometimes it just takes a few days to come to it.

> I have some general questions:
> 
> My thought was to squash all the commits into a single one once the code is in
> good enough shape. Do you prefer to keep the commit history?

In general I'm not so much interested in the commit history. The 
interest is more to have big changes split into a useful, always 
buildable and easy to review series of commits.

We also want to have new features and bug fixes as well as cleanups in 
separate commits. This all could sound a bit overloading when doing a 
first series of patches (also the git send mail thing I comment on 
below). I try to not be to pedantic but some things I really have.

If I look over your changes a potential series would be:
0001: Update atusb header with hw board define to sync up with firmware
0002: Basic refactor of atusb to enable easy support for a new board 
(hw_name and chip_data changes for example) [This would need to be done 
for rzusb and atusb only and need to build and work without the last patch]
0003: Finally add support for hulusb with all remaining needed changes.

If it turns out that having 2 & 3 as split commits it to complicated and 
the merged patch is not really that big we can also go for a merged version.

If you are going to have some generic bug fixes in there they would need 
to be separated out into signle commits and put in the beginning of the 
series though.

> I did debug the firmware over UART. I thought it might be a useful option to
> other developers (using the DEBUG flag) working on this firmware, but i can of
> course also remove my debug code completely if it is not needed?

Good question. I can see the debugging functionality being useful during 
bringup, just not during the normal lifetime. I'm happy to get the 
uart.c and additional changes as a patch to the firmware as long as it 
is off by default and we do not have to many debug statements sprinkled 
all over the code. :)

>> As for review I can go through your changes on the github links and do
>> some initial review there but the final patches and review to get
>> applied to the tree need to come as git patches to this mailing list.
> 
> I have seen the git send-email tutorial on the linux-wpan homepage (To change
> the homepage). Never used git send-email before but i guess this is how it
> should be done with the code as well, once the code is in good shape.

Yes, git send mail to this list is the final step to get review and the 
patches applied in the end. It can be a bit steep for first time users.
If you have trouble asking here is fine but there should also be some 
good tips in the kernel Documentation folder or on the internet.

What I normally do is something like this:

git format-patch --subject-prefix="PATCH bluetooth-next" -s -3 
--cover-letter

git send-email --to=linux-wpan@vger.kernel.org --smtp-server=XXX 
--smtp-user="XXX --smtp-server-port=587 --smtp-encryption=tls 000*

It would take your latest three commits, adjust the subject prefix, make 
sure they are signed off and finally send them to the list through your 
smtp server.

>> I also send you the address from my private mail (datenfreihafen.org).
>> Did this one end up in your SPAM folder? That would be odd.
> 
> It actually did. No clue why :)

Odd, I did never really had trouble with my private address before. 
Thanks for letting me know.

regards
Stefan Schmidt
