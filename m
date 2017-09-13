Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from ec2-52-27-115-49.us-west-2.compute.amazonaws.com ([52.27.115.49]:39416
        "EHLO osg.samsung.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751458AbdIMQIr (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Wed, 13 Sep 2017 12:08:47 -0400
Received: from localhost (localhost [127.0.0.1])
        by osg.samsung.com (Postfix) with ESMTP id 55515A097F
        for <linux-wpan@vger.kernel.org>; Wed, 13 Sep 2017 16:09:15 +0000 (UTC)
Received: from osg.samsung.com ([127.0.0.1])
        by localhost (s-opensource.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id bdmEJxUogFJt for <linux-wpan@vger.kernel.org>;
        Wed, 13 Sep 2017 16:09:14 +0000 (UTC)
Received: from [192.168.2.112] (pD9F79C1B.dip0.t-ipconnect.de [217.247.156.27])
        by osg.samsung.com (Postfix) with ESMTPSA id 6E918A0C16
        for <linux-wpan@vger.kernel.org>; Wed, 13 Sep 2017 16:09:14 +0000 (UTC)
Subject: Re: [PATCH atusb/fw v2 0/2] atusb/fw: Firmware patch to support
 HULUSB v2
References: <20170911115833.24957-1-j.filzmaier@gmx.at>
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <509f02b8-355b-7bcf-16ef-41707c689bbd@osg.samsung.com>
Date: Wed, 13 Sep 2017 18:08:43 +0200
MIME-Version: 1.0
In-Reply-To: <20170911115833.24957-1-j.filzmaier@gmx.at>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org

Hello.

On 09/11/2017 01:58 PM, Josef Filzmaier wrote:
> This patch (in combination with the linux kernel patch)
> introduces support for the Busware HUL stick. There are two
> commits, one that enables UART debugging (for convenience purposes)
> and another that modularizes the firmware to better support
> multiple hardware targets. As the Busware HUL stick uses the
> at86rf212 transceiver there have been a few modifications to
> support this transceiver. Otherwise this board is very similar to the
> already existing atusb and rzusb boards, meaning most of the code
> can be shared. (e.g. it also uses the at90usb1287 microcontroller).
> 
> Josef Filzmaier (2):
>    atusb/fw: Introduce DEBUG flag
>    atusb/fw: Introduction of a new board named HULUSB

Both patches have been applied to the atusb firmware repo.
I also added a tiny section in the README how to get the firmware on the 
device.

Thanks a lot for your efforts on this!

I will have a look at the kernel driver tomorrow as I run out of time today.

regards
Stefan Schmidt
