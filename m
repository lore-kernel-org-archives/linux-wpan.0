Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from senator.holtmann.net ([87.106.208.187]:60717 "EHLO
	mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752625AbbE1QLO (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 28 May 2015 12:11:14 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: [PATCH,RFC bluetooth-next 2/2] ieee802154: Fix EUI-64 station address validation.
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20150528123843.GE11340@wantstofly.org>
Date: Thu, 28 May 2015 18:11:11 +0200
Content-Transfer-Encoding: 7bit
Message-Id: <0E6D17B7-F167-429E-A1D7-5588932E86EC@holtmann.org>
References: <53cacc49e75b59f7b6458075b032be16f1133abb.1432816524.git.buytenh@wantstofly.org> <20150528123843.GE11340@wantstofly.org>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Lennert Buytenhek <buytenh@wantstofly.org>
Cc: linux-wpan@vger.kernel.org

Hi Lennert,

> Refuse to allow setting an EUI-64 group address as an interface
> address, as those are not valid station addresses.
> 
> Signed-off-by: Lennert Buytenhek <buytenh@wantstofly.org>
> ---
> include/linux/ieee802154.h | 10 ++++------
> net/mac802154/iface.c      |  4 ++--
> 2 files changed, 6 insertions(+), 8 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

