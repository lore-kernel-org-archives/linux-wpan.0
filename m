Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from cs43706557.123-cloud-server.co.uk ([91.109.11.113]:39464 "EHLO
        cs43706557.123-cloud-server.co.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752125AbeC1KbU (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>);
        Wed, 28 Mar 2018 06:31:20 -0400
Reply-To: h.morris@cascoda.com
Subject: Re: [PATCH 0/1] ieee802154: ca8210: Fix potential security exploit
References: <20180327134544.16986-1-h.morris@cascoda.com>
From: Harry Morris <h.morris@cascoda.com>
Message-ID: <fd8413d7-c8c4-4701-9f43-73496e577a85@cascoda.com>
Date: Wed, 28 Mar 2018 11:23:17 +0100
MIME-Version: 1.0
In-Reply-To: <20180327134544.16986-1-h.morris@cascoda.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: stefan@osg.samsung.com, aring@mojatatu.com

Please ignore this for the time being, I'll be issuing a v2 soon...

Harry


On 27/03/2018 14:45, harrymorris12@gmail.com wrote:
> From: Harry Morris <h.morris@cascoda.com>
>
> This patchset fixes a small bug in the ca8210 driver discovered by Domen Puncer Kugler <domen.puncer@samsung.com>.
>
> The bug allows for uninitialised memory to be sent out over SPI by writing unexpected commands to the debug interface. The bug is described in more detail in 1/1.
>
> This fix has been tested on a Raspberry Pi running kernel 4.9.37-v7+:
>
> harry@raspberrypi:~ $ sudo bash -c 'echo -ne "\x4f\x10" > /sys/kernel/debug/ca8210'
> bash: line 0: echo: write error: Message too long
> harry@raspberrypi:~ $
>
> Harry Morris (1):
>    ieee802154: ca8210: fix uninitialised data read
>
>   drivers/net/ieee802154/ca8210.c | 7 +++++++
>   1 file changed, 7 insertions(+)
>
