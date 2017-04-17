Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:34363 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753283AbdDQNcD (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>);
        Mon, 17 Apr 2017 09:32:03 -0400
Subject: Re: llsec: command failed: Operation not supported (-95)
References: <1492430559.14787.49.camel@boxhill.edu.au>
From: Alexander Aring <aar@pengutronix.de>
Message-ID: <0d63c71c-d334-cd62-065e-b003a44bdced@pengutronix.de>
Date: Mon, 17 Apr 2017 15:32:00 +0200
MIME-Version: 1.0
In-Reply-To: <1492430559.14787.49.camel@boxhill.edu.au>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Jan Newmarch <j.newmarch@boxhill.edu.au>
Cc: "linux-wpan@vger.kernel.org" <linux-wpan@vger.kernel.org>

Hi,

On 04/17/2017 02:01 PM, Jan Newmarch wrote:
> Running 802.15.4 and 6LoWPAN successfully on RPi using the OpenLabs
> module. Can ping, run UDP, TCP programs etc okay to another RPi. Tried
> to add llsec using wpan-tools from https://github.com/linux-wpan/wpan-t
> ools/tree/nl802154_llsec, with instructions given by Stefan Schmidt at
> http://events.linuxfoundation.org/sites/events/files/slides/openiot-201
> 6-linux-wpan_0.pdf
> 
> On running
>    ./iwpan dev wpan0 set security 1
> I get
>    command failed: Operation not supported (-95)
> after executing
>    nl_recvmsgs(state->nl_sock, cb);
> line 445, iwpan.c
> 
> I guess I'm missing something, not sure what.
> 
> $ ./iwpan wpan0 info
> Interface wpan0
>         ifindex 3
>         wpan_dev 0x1
>         extended_addr 0x0200000000000001
>         short_addr 0xffff
>         pan_id 0xbeef
>         type node
>         max_frame_retries 3
>         min_be 3
>         max_be 5
>         max_csma_backoffs 4
>         lbt 0
>         ackreq_default 0
> 
> $ uname -a
> Linux raspberrypi 4.7.2-v7+ #1 SMP Fri Aug 26 15:45:29 UTC 2016 armv7l
> GNU/Linux
> 

Don't know yet when I added support for it in the kernel - maybe use bluetooth-next?
It's currently a experimental feature, you need to enable:

IEEE802154_NL802154_EXPERIMENTAL

---
Also there exists some cases on dumping where the kernel crashes (I
have it on my list) It's because monitor interfaces doesn't has softmac
layers and doesn't need that all security related stuff. Maybe you can
send patches? It occurs when dumping values with iwpan.

Don't know how to send patches? There exists lot's of youtube tutorials
from Greg Kroah Hartmann. :-)

- Alex
