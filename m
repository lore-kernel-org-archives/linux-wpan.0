Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:37521 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751812AbdABPwB (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 2 Jan 2017 10:52:01 -0500
Subject: Re: please help me process for libcoap and and 6lowpan integration.
References: <CAAK7Ti-6NypT=jTFeuFv=Ka3EDDzzbnrqbRuv9PU0EaW3ibEhg@mail.gmail.com>
From: Alexander Aring <aar@pengutronix.de>
Message-ID: <141e39b2-da67-2bfa-bc57-61083d071fe9@pengutronix.de>
Date: Mon, 2 Jan 2017 16:51:59 +0100
MIME-Version: 1.0
In-Reply-To: <CAAK7Ti-6NypT=jTFeuFv=Ka3EDDzzbnrqbRuv9PU0EaW3ibEhg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: JANARDHANACHARI KELLA <eni.chari@gmail.com>
Cc: linux-wpan@vger.kernel.org


Hi,

On 01/02/2017 09:57 AM, JANARDHANACHARI KELLA wrote:
> Hi,
> 
> I am trying for coap to release through wpan interfece. for generating
> coap packet i am using libcoap.  can any one tried for generate packet
> like bellow.
> 
> Protocols in frame: wpan:6lowpan:ipv6:ipv6.nxt:udp:coap.data
> 
> please give any information to release coap packets with wpan interface.
> 

you need a 6lowpan interface to do that.

See:

http://wpan.cakelab.org/#_6lowpan

- Alex
