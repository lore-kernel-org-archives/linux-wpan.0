Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from ec2-52-27-115-49.us-west-2.compute.amazonaws.com ([52.27.115.49]:50877
        "EHLO osg.samsung.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753106AbcK3KXP (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Wed, 30 Nov 2016 05:23:15 -0500
Subject: Re: Project Todo list updated
References: <6e9208bd-cd35-bf0b-e55a-b06b0202c79a@osg.samsung.com>
 <d54f371e-ba02-71dc-6208-228560a51d00@pengutronix.de>
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <c8b12a51-c756-6160-708f-942578403c39@osg.samsung.com>
Date: Wed, 30 Nov 2016 11:23:11 +0100
MIME-Version: 1.0
In-Reply-To: <d54f371e-ba02-71dc-6208-228560a51d00@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <aar@pengutronix.de>
Cc: "linux-wpan@vger.kernel.org" <linux-wpan@vger.kernel.org>

Hello.

On 30/11/16 10:19, Alexander Aring wrote:
>
>
> During my thesis I think I found some stuff which I want to bring
> mainline to the subsystems 802.15.4/6lowpan can deal with some parts.
>
> Currently I have very hacked solutions for it, but I think I know what I
> need to make it mainline acceptable. This is:
>
> 1. 6lowpan netlink interface.

What do you mean here? A configuration interface for 6lowpan or 
something else?

>
> 2. L2_PKTINFO for SOCK_RAW/SOCK_DGRAM IPv6 sockets

Added to the todo list and marked it as being worked on by you.

> 3. iptable 6lowpan stuff/which can also deal with some L2 infos. Really
>    weird mixing L3 and L2 info in rules. :-/ Currently it's hard coded
>    at my side.

Added to the todo list and marked it as being worked on by you.

> 4. node info dump

Marked as being worked on by you.

regards
Stefan Schmidt
