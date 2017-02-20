Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:55615 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750920AbdBTIed (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>);
        Mon, 20 Feb 2017 03:34:33 -0500
Subject: Re: Register two 802.15.4 devices/interfaces in one driver
References: <CAJuUDwuKQvpXhZKKAmBLReUd4+LOqS3+5CaGjRR6DNcRkQgrVw@mail.gmail.com>
 <28517.1487255767@obiwan.sandelman.ca>
 <193c0df2-d259-9076-c442-5731f6124e50@pengutronix.de>
 <32430.1487274266@obiwan.sandelman.ca>
 <7eae598a-c56e-2aac-c0f4-cef9b92dc23b@pengutronix.de>
 <10193.1487347973@obiwan.sandelman.ca>
From: Alexander Aring <aar@pengutronix.de>
Message-ID: <c55ce28b-13a3-b0a8-f62d-be9f923081de@pengutronix.de>
Date: Mon, 20 Feb 2017 09:34:29 +0100
MIME-Version: 1.0
In-Reply-To: <10193.1487347973@obiwan.sandelman.ca>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Michael Richardson <mcr@sandelman.ca>
Cc: Xue Liu <liuxuenetmail@gmail.com>, linux-wpan@vger.kernel.org


Hi,

On 02/17/2017 05:12 PM, Michael Richardson wrote:
> 
> Alexander Aring <aar@pengutronix.de> wrote:
>     > Yes, turn transceiver "quietly" (maybe some pr_info notice) into
>     > promiscuous mode or (if supported) turn off address filtering only.
>     > Needs some driver layer changed and subsystem changes to allow it.
> 
>     > And this all quietly, just make a pr_info notice for networking experts
>     > why your interrupt load for the transceiver will be increased.
> 
> Yup. Clearly if you try to do things in software to compensate for lacks in
> hardware, there is a cost.  That's fine as long as nobody is surprised.
> 

rethinking of this while taking a shower... Then we need some kind of
software ACK handling, because disable address filter will occur, if you
don't disable ACK handling, you ack all frames which arrived.

We need somehow to check fast if we have such interface with this
address -> then sending ack out so fast as possible... we can try it but
I cannot promise that the time will always match.

- Alex
