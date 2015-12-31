Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from [82.165.8.211] ([82.165.8.211]:46700 "EHLO mail.holtmann.org"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752419AbbLaTGN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 31 Dec 2015 14:06:13 -0500
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Subject: Re: [PATCH v3 0/1] ieee802154: cc2520: Check CRC & add promiscuous
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1450923581-967-1-git-send-email-bradjc5@gmail.com>
Date: Thu, 31 Dec 2015 11:06:08 -0800
Content-Transfer-Encoding: 8BIT
Message-Id: <7D09DDD7-A61B-4CF1-8D67-DC8E8F5EC2C1@holtmann.org>
References: <1450923581-967-1-git-send-email-bradjc5@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Brad Campbell <bradjc5@gmail.com>
Cc: Varka Bhadram <varkabhadram@gmail.com>, Alexander Aring <alex.aring@gmail.com>, linux-wpan@vger.kernel.org

Hi Brad,

> Update the patch to disable AUTOCRC and manually set CRC on TX when in
> promiscuous mode rather than recreating the CRC upon receive.
> 
> I've tested that in monitor mode all packets are received with the CRC, and
> in node mode packets are being filtered as expected.
> 
> Changes since v2:
> - Disable AUTOCRC when in promiscuous mode rather than manually
> calculating CRC
> - Add CRC manually for TX when in promiscuous mode
> - Remove initializing FRMCTRL0 as it is set when promiscuous mode
> is configured.
> 
> Changes since v1:
> - Add support for promiscuous mode in cc2520
> - Make frame filtering default
> - Append CRC to incoming packets for monitors
> - Actually calculate LQI
> 
> Brad Campbell (1):
>  ieee802154: cc2520: Check CRC & add promiscuous
> 
> drivers/net/ieee802154/cc2520.c | 145 +++++++++++++++++++++++++++++++++-------
> 1 file changed, 122 insertions(+), 23 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

