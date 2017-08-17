Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from ec2-52-27-115-49.us-west-2.compute.amazonaws.com ([52.27.115.49]:49826
        "EHLO osg.samsung.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750959AbdHQKNU (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Thu, 17 Aug 2017 06:13:20 -0400
Received: from localhost (localhost [127.0.0.1])
        by osg.samsung.com (Postfix) with ESMTP id F03A3A0CAD
        for <linux-wpan@vger.kernel.org>; Thu, 17 Aug 2017 10:13:47 +0000 (UTC)
Received: from osg.samsung.com ([127.0.0.1])
        by localhost (s-opensource.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id KtOH6MuzUzQy for <linux-wpan@vger.kernel.org>;
        Thu, 17 Aug 2017 10:13:47 +0000 (UTC)
Received: from [192.168.2.112] (pD9F79285.dip0.t-ipconnect.de [217.247.146.133])
        by osg.samsung.com (Postfix) with ESMTPSA id 1F0CAA0C9D
        for <linux-wpan@vger.kernel.org>; Thu, 17 Aug 2017 10:13:46 +0000 (UTC)
Subject: Re: AT86RF212 based USB-Stick (HUL)
References: <5179358.aL3rf9WXy9@hella-laptop>
 <215b5391-2082-6061-5365-b693008c9c9d@osg.samsung.com>
 <1551752.M6fFiAEvOh@hella-laptop> <1648899.xXhEr7NW1d@hella-laptop>
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <f21e7ad7-1306-423e-1408-710bf26a94bc@osg.samsung.com>
Date: Thu, 17 Aug 2017 12:13:17 +0200
MIME-Version: 1.0
In-Reply-To: <1648899.xXhEr7NW1d@hella-laptop>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org

Hello.

On 08/17/2017 10:28 AM, Josef Filzmaier wrote:
> Hello!
> 
>> 1) The atusb_xmit function is only called *once* and then never again
> 
> I just managed to fix this problem, too. I did configure the interrupt of the
> microcontroller in the firmware incorrectly. So i did never get an interrupt
> and the kernel was never informed that the frame was transmitted successfully
> (atusb_tx_done was missing) I will send you the link to an updated patch once
> i've tested it a bit more.
> 

Great!

I see yo used TIMER1_CAPT_vect as rzusb does but it needed to be 
INT0_vect like we do on the ATUSB. Tricky little beast this firmware. :)

regards
Stefan Schmidt
