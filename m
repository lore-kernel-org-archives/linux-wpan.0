Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:33251 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755431AbdACHZm (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Tue, 3 Jan 2017 02:25:42 -0500
Subject: Re: please help me process for libcoap and and 6lowpan integration.
References: <CAAK7Ti-6NypT=jTFeuFv=Ka3EDDzzbnrqbRuv9PU0EaW3ibEhg@mail.gmail.com>
 <141e39b2-da67-2bfa-bc57-61083d071fe9@pengutronix.de>
 <CAAK7Ti9=p+QaJZBiczQ5xAcBBsmdQObfYwG2TfmsS2i39f_CoQ@mail.gmail.com>
From: Alexander Aring <aar@pengutronix.de>
Message-ID: <4d9369af-5384-98d0-399f-3474abaf75c3@pengutronix.de>
Date: Tue, 3 Jan 2017 08:25:40 +0100
MIME-Version: 1.0
In-Reply-To: <CAAK7Ti9=p+QaJZBiczQ5xAcBBsmdQObfYwG2TfmsS2i39f_CoQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: JANARDHANACHARI KELLA <eni.chari@gmail.com>
Cc: "linux-wpan@vger.kernel.org" <linux-wpan@vger.kernel.org>

Hi,

On 01/02/2017 06:17 PM, JANARDHANACHARI KELLA wrote:
> Thankq Alex for your reply.
> 
> I have already, using flakelb driver and prepared lowpan Interface. I have
> tested configuration with wpan-tools/example/af_inet6_tx.c and Rx.c files.
> I am able to find the 6lowpan packet at wpan0 virtual PHY. So, that I am
> moving towards integration of 6lowpan and coap.
> 
> Please give me suggestion.
> 

no top post please and keep mailinglist in cc.

If you have lowpan interface it's just the same as you using ethernet
ipv6.

- Alex
