Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:43977 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750850AbcDTSzo (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>);
	Wed, 20 Apr 2016 14:55:44 -0400
Subject: Re: [PATCH bluetooth-next 1/4] ieee802154: atusb: implement
 .set_csma_params ops callback
References: <1461076135-31540-1-git-send-email-stefan@osg.samsung.com>
From: Alexander Aring <aar@pengutronix.de>
Message-ID: <b02d54d3-7f09-e946-6dbd-316f697fc422@pengutronix.de>
Date: Wed, 20 Apr 2016 20:55:41 +0200
MIME-Version: 1.0
In-Reply-To: <1461076135-31540-1-git-send-email-stefan@osg.samsung.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stefan Schmidt <stefan@osg.samsung.com>, linux-wpan@vger.kernel.org


Hi,

On 04/19/2016 04:28 PM, Stefan Schmidt wrote:
> Catching up with the stack here and implement CSMA parameter setting.
> 
> Signed-off-by: Stefan Schmidt <stefan@osg.samsung.com>

all patches are fine. I want to remember this settings have no effects
until atusb has TX_ARET support and drops basic operation mode.

But I am sure you already known that and this will part of next firmware
version.

Also please care of ed-levels if they are the same on at86rf230, don't
known yet. There is some calculation with rssi_base_val parameter which
is on 2.4 Ghz always -91.

- Alex
