Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from senator.holtmann.net ([87.106.208.187]:53524 "EHLO
	mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932994AbbCRQwd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 18 Mar 2015 12:52:33 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Subject: Re: [PATCHv3 bluetooth-next 0/2] Add CC2591 Support
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1426623946-6651-1-git-send-email-bradjc5@gmail.com>
Date: Wed, 18 Mar 2015 09:52:27 -0700
Content-Transfer-Encoding: 8BIT
Message-Id: <87177423-5B27-4636-A31A-5B0E672FCE18@holtmann.org>
References: <1426623946-6651-1-git-send-email-bradjc5@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Brad Campbell <bradjc5@gmail.com>
Cc: linux-wpan@vger.kernel.org, alex.aring@gmail.com

Hi Brad,

> I fixed the two issues that Alex pointed out and updated the
> commit message.
> 
> Brad
> 
> Brad Campbell (2):
>  cc2520: Do not store platform_data in spi_device
>  cc2520: Add support for CC2591 amplifier.
> 
> .../devicetree/bindings/net/ieee802154/cc2520.txt  |   4 +
> drivers/net/ieee802154/cc2520.c                    | 150 +++++++++++++--------
> include/linux/spi/cc2520.h                         |   1 +
> 3 files changed, 98 insertions(+), 57 deletions(-)

both patches have been applied to bluetooth-next tree.

Regards

Marcel

