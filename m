Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:59417 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751509AbdARJ3c (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>);
        Wed, 18 Jan 2017 04:29:32 -0500
Subject: Re: please help me to integrate RPL in kernel
References: <CAAK7Ti8iY8O2W44948xaQA5t2WRxXT1uWTCCqW0N1Z10fqw+EQ@mail.gmail.com>
From: Alexander Aring <aar@pengutronix.de>
Message-ID: <2796f0bf-e7dc-b2c2-fa05-64bacd7d6b26@pengutronix.de>
Date: Wed, 18 Jan 2017 10:28:38 +0100
MIME-Version: 1.0
In-Reply-To: <CAAK7Ti8iY8O2W44948xaQA5t2WRxXT1uWTCCqW0N1Z10fqw+EQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: JANARDHANACHARI KELLA <eni.chari@gmail.com>
Cc: linux-wpan@vger.kernel.org


Hi,

On 01/18/2017 08:48 AM, JANARDHANACHARI KELLA wrote:
> Hi,
> 
> i am trying to integrate RPL feature in linux kernel to use on
> raspberry pi2 b with at86rf233 module. can any on suggest/ provide any
> information to integrate RPL feature?
> 
> is this Rpl feature supported for new kernels like(4.x)? for rpl which
> kernel i have to use?
> 

look into unstrung implementation. Works well on my side.

Badly there is no other documentation you need to dig into that
yourself.

Also it depends on your use-case if you don't need to hack other things
into unstrung which you need.

- Alex
