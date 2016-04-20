Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from ipv4.connman.net ([82.165.8.211]:59468 "EHLO mail.holtmann.org"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751228AbcDTWW5 (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Wed, 20 Apr 2016 18:22:57 -0400
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH bluetooth-next 1/4] ieee802154: atusb: implement .set_csma_params ops callback
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <b02d54d3-7f09-e946-6dbd-316f697fc422@pengutronix.de>
Date: Thu, 21 Apr 2016 00:22:55 +0200
Content-Transfer-Encoding: 7bit
Message-Id: <F9DBF1AD-6D1B-48F3-8354-B47C4A9CD43E@holtmann.org>
References: <1461076135-31540-1-git-send-email-stefan@osg.samsung.com> <b02d54d3-7f09-e946-6dbd-316f697fc422@pengutronix.de>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <aar@pengutronix.de>
Cc: Stefan Schmidt <stefan@osg.samsung.com>, linux-wpan@vger.kernel.org

Hi Alex,

>> Catching up with the stack here and implement CSMA parameter setting.
>> 
>> Signed-off-by: Stefan Schmidt <stefan@osg.samsung.com>
> 
> all patches are fine. I want to remember this settings have no effects
> until atusb has TX_ARET support and drops basic operation mode.

I have applied all 4 patches to bluetooth-next tree.

Regards

Marcel

