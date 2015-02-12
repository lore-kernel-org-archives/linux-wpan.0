Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from senator.holtmann.net ([87.106.208.187]:56309 "EHLO
	mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752246AbbBLUim convert rfc822-to-8bit (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 12 Feb 2015 15:38:42 -0500
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Subject: Re: [PATCHv2 bluetooth-next 0/3] ieee802154: small cleanups
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1423661957-3485-1-git-send-email-alex.aring@gmail.com>
Date: Thu, 12 Feb 2015 12:37:58 -0800
Content-Transfer-Encoding: 8BIT
Message-Id: <EE5E14A8-9FDC-4721-96B1-AC085FB86D6A@holtmann.org>
References: <1423661957-3485-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de

Hi Alex,

> this patch series contains some small cleanups. THe first patch do a more
> correct checking on valid psdu len, this is necessary e.g. in at86rf230
> promiscous mode frame length checking to avoid an access out of mpdu buffer.
> The last two patches simple remove some unnecessary temporary variable.
> 
> - Alex
> 
> changes since v2:
> 
> - use __put_unaligned_memmove64 for handle unaligned pointer access
>  in Patch 2/3 and 3/3.
> 
> Alexander Aring (3):
>  ieee802154: correct ieee802154_is_valid_psdu_len
>  ieee802154: cleanup ieee802154_be64_to_le64
>  ieee802154: cleanup ieee802154_le64_to_be64
> 
> include/linux/ieee802154.h | 12 ++++++++++--
> include/net/mac802154.h    |  9 +++------
> 2 files changed, 13 insertions(+), 8 deletions(-)

all 3 patches have been applied to bluetooth-next tree.

Regards

Marcel

