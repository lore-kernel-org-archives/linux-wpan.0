Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from ec2-52-27-115-49.us-west-2.compute.amazonaws.com ([52.27.115.49]:44749
        "EHLO osg.samsung.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751316AbdINNdL (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Thu, 14 Sep 2017 09:33:11 -0400
Subject: Re: [PATCH bluetooth-next 1/1] atusb: Driver support for Busware HUL
 USB dongle
References: <20170901231829.31279-1-j.filzmaier@gmx.at>
 <20170901231829.31279-2-j.filzmaier@gmx.at>
 <b1efa4f0-ccee-72db-4fcb-f6e189ae3319@osg.samsung.com>
 <7924089.9ctYqWRe3X@hella-laptop>
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <c4424060-51aa-ae5f-d040-99a0a713e079@osg.samsung.com>
Date: Thu, 14 Sep 2017 15:33:07 +0200
MIME-Version: 1.0
In-Reply-To: <7924089.9ctYqWRe3X@hella-laptop>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Josef Filzmaier <j.filzmaier@gmx.at>, linux-wpan@vger.kernel.org

Hello.

On 09/14/2017 02:32 PM, Josef Filzmaier wrote:
>> Hello.
> 
> Hello!
> 
>> Could you add a ieee802154: before the atusb: in the subject? That makes
>> it clearer to what area of the kernel it belongs.
> 
> Yes, i did just resubmit my patch.
> 
>> scripts/checkpatch.pl --strict $PATCHNAME
> 
> I did not know this script existed, otherwise i would have checked earlier. :)

We need to have _some_ secrets, right? ;)

If you want to learn more about kernel development (you learned and 
adapted quickly) dig through the Documentation folder. Its a mix of 
technical but also development docs.

>> Both patches have been applied to the atusb firmware repo.
>> I also added a tiny section in the README how to get the firmware on the
>> device.
> 
>> Thanks a lot for your efforts on this!
> 
> Thank you very much for your support!

Let us know how the development on top of this device and the upcoming 
hardware with a SPI attached transceiver goes. Hearing stories how the 
stack can be used and what shortcomings it has will help us to improve.

regards
Stefan Schmidt
