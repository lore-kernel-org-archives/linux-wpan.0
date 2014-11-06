Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from senator.holtmann.net ([87.106.208.187]:41727 "EHLO
	mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750887AbaKFPgm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 6 Nov 2014 10:36:42 -0500
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.0 \(1990.1\))
Subject: Re: 6lowpan with external radio
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAGnRvuo+4fpbn6TTzFujaJ_agf+sCZxV1T5a9hmmZ4z29OCEHA@mail.gmail.com>
Date: Thu, 6 Nov 2014 07:36:34 -0800
Content-Transfer-Encoding: 8BIT
Message-Id: <CD68F300-602D-4CDA-AD92-FEE5F393AB17@holtmann.org>
References: <CAGnRvuo+4fpbn6TTzFujaJ_agf+sCZxV1T5a9hmmZ4z29OCEHA@mail.gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Henning Rogge <hrogge@gmail.com>
Cc: linux-wpan@vger.kernel.org

Hi Henning,

> I am working with an external VHF radio attached over a serial
> connection (USB serial at the moment) and looking for a way to use the
> Linux 6lowpan stack with this radio.
> 
> Is there a way to get a TUN/TAP equivalent for 6lowpan, just getting
> the raw frames back through a socket into userspace?

there is no interface for this. You will need to build an interface to create 6LoWPAN network devices from userspace and allow reading/writing from it.

Regards

Marcel

