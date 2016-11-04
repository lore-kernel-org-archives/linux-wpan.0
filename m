Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from ec2-52-27-115-49.us-west-2.compute.amazonaws.com ([52.27.115.49]:53083
        "EHLO osg.samsung.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S934681AbcKDO3J (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Fri, 4 Nov 2016 10:29:09 -0400
Received: from localhost (localhost [127.0.0.1])
        by osg.samsung.com (Postfix) with ESMTP id 2C852A0E76
        for <linux-wpan@vger.kernel.org>; Fri,  4 Nov 2016 14:29:17 +0000 (UTC)
Received: from osg.samsung.com ([127.0.0.1])
        by localhost (s-opensource.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ztuljHspcxEf for <linux-wpan@vger.kernel.org>;
        Fri,  4 Nov 2016 14:29:16 +0000 (UTC)
Received: from [192.168.2.110] (unknown [217.247.128.47])
        by osg.samsung.com (Postfix) with ESMTPSA id 4F60DA0E75
        for <linux-wpan@vger.kernel.org>; Fri,  4 Nov 2016 14:29:16 +0000 (UTC)
Subject: Re: How to use wpan-ping
References: <CAJuUDwsJvZ0gjcSP02vjAkR4PX6BQq=jTEtMoHtcXheY1kvS7Q@mail.gmail.com>
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <f4f8a2d3-5233-0ccf-5808-02126cf9d514@osg.samsung.com>
Date: Fri, 4 Nov 2016 15:28:43 +0100
MIME-Version: 1.0
In-Reply-To: <CAJuUDwsJvZ0gjcSP02vjAkR4PX6BQq=jTEtMoHtcXheY1kvS7Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org

Hello.

On 04/11/16 14:19, Xue Liu wrote:
> Hello everyone,
>
> I would like to use latest wpan-ping in RPi3 4.4.28 with ATUSB stick
> (latest firmware).

Interesting combination to use a USB dongle on the Pi :)

  I follow the README.wpan-ping as “./wpan-ping -d
> 0x0001” or "wpan-ping -a 0x0003 -c 5 -s 114", but I got en error
> message:
>
> bind: No such device

It can't find the device it should bind to. Did you setup a short 
address for the interface?

iwpan dev will tell us.

> even with parameter “-i wpan0”.

This interface is only used to get the address over netlink. It needs to 
be set before with iwpan though.

This interface is not used on the server side to bind to the device 
because this would need extra permissions I wanted to avoid for this 
small utility.

> Does wpan-ping require latest kernel like bluetooth-next ? Or did I
> miss something ?

It should not depend on anything new.

regards
Stefan Schmidt
