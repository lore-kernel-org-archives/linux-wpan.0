Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from ec2-52-27-115-49.us-west-2.compute.amazonaws.com ([52.27.115.49]:49819
        "EHLO osg.samsung.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752374AbdHQKKt (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Thu, 17 Aug 2017 06:10:49 -0400
Received: from localhost (localhost [127.0.0.1])
        by osg.samsung.com (Postfix) with ESMTP id 14CAAA0CAD
        for <linux-wpan@vger.kernel.org>; Thu, 17 Aug 2017 10:11:17 +0000 (UTC)
Received: from osg.samsung.com ([127.0.0.1])
        by localhost (s-opensource.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id v79ZHL8uO4Zl for <linux-wpan@vger.kernel.org>;
        Thu, 17 Aug 2017 10:11:16 +0000 (UTC)
Received: from [192.168.2.112] (pD9F79285.dip0.t-ipconnect.de [217.247.146.133])
        by osg.samsung.com (Postfix) with ESMTPSA id 2C5B7A0C9D
        for <linux-wpan@vger.kernel.org>; Thu, 17 Aug 2017 10:11:16 +0000 (UTC)
Subject: Re: AT86RF212 based USB-Stick (HUL)
References: <5179358.aL3rf9WXy9@hella-laptop>
 <3182719.nDP85ksrvE@hella-laptop>
 <215b5391-2082-6061-5365-b693008c9c9d@osg.samsung.com>
 <1551752.M6fFiAEvOh@hella-laptop>
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <17366136-0ab6-99ea-89e4-916938a0ed17@osg.samsung.com>
Date: Thu, 17 Aug 2017 12:10:45 +0200
MIME-Version: 1.0
In-Reply-To: <1551752.M6fFiAEvOh@hella-laptop>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org

Hello.

On 08/16/2017 05:33 PM, Josef Filzmaier wrote:
> Hello again :)
> 
>> Let me know how it goes.
> 
> I have made some progress regarding the busware hul stick support. I had two
> major problems:
> 
> 1) The atusb_xmit function is only called *once* and then never again

I will skip this part here as you already sent another mail stating it 
came back to using the wrong INT in the firmware.

> 2) Configuring page, channel and txpower did not work.
> 
> I think that i did fix 2) successfully. (Firmware Patch: [1], Kernel Patch: [2]
> (Please ignore the modified device tree)) I hopefully did not break
> compatability with rzusb and atusb, could you please verify that and give some
> comments on my code?

As a first step I will go and test your firmware changes only on the 
atusb and rzusb devices to make sure nothing breaks with the current 
mainline driver.

Testing it with the atusb driver changes applied is the next step.

As for review I can go through your changes on the github links and do 
some initial review there but the final patches and review to get 
applied to the tree need to come as git patches to this mailing list.

>> That would be great. I will send you my address directly.
> 
> I just realized that your email with the address was in my spam folder. I will
> send you one ASAP.

I actually had to send it to you twice because the mails from my company 
address will not get through to gmx.at. I think this is due to some odd 
configuration on our side. nothign I can fix myself but I can bring it 
up at least.

I also send you the address from my private mail (datenfreihafen.org). 
Did this one end up in your SPAM folder? That would be odd.

regards
Stefan Schmidt
