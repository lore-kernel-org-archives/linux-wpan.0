Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:49131 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932930AbdACI3g (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Tue, 3 Jan 2017 03:29:36 -0500
Subject: Re: please help me process for libcoap and and 6lowpan integration.
References: <CAAK7Ti-6NypT=jTFeuFv=Ka3EDDzzbnrqbRuv9PU0EaW3ibEhg@mail.gmail.com>
 <141e39b2-da67-2bfa-bc57-61083d071fe9@pengutronix.de>
 <CAAK7Ti9=p+QaJZBiczQ5xAcBBsmdQObfYwG2TfmsS2i39f_CoQ@mail.gmail.com>
 <4d9369af-5384-98d0-399f-3474abaf75c3@pengutronix.de>
 <CAAK7Ti953hfv0s1Dns6yomGqdhbj8tB47aa7LAY5qY8gbSZ75Q@mail.gmail.com>
From: Alexander Aring <aar@pengutronix.de>
Message-ID: <b6e197dc-c60a-90ef-716f-7047e3bff0ec@pengutronix.de>
Date: Tue, 3 Jan 2017 09:29:35 +0100
MIME-Version: 1.0
In-Reply-To: <CAAK7Ti953hfv0s1Dns6yomGqdhbj8tB47aa7LAY5qY8gbSZ75Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: JANARDHANACHARI KELLA <eni.chari@gmail.com>
Cc: linux-wpan@vger.kernel.org


Hi,

On 01/03/2017 09:26 AM, JANARDHANACHARI KELLA wrote:
> thankq Alex.
> 
> have you any idea about, where i have to go through in libcoap code to
> drive the packet towards lowpan?
> 

no top post here, please write your answers text below mine.

Yes, the normal IPv6 POSIX Linux Socket API as you use in Ethernet.

- Alex
