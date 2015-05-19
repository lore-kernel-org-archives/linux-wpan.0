Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from senator.holtmann.net ([87.106.208.187]:43770 "EHLO
	mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750879AbbESRjI (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 19 May 2015 13:39:08 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: [PATCH] mac802154: select CRYPTO when needed
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <4189396.LhxDXkIPfr@wuerfel>
Date: Tue, 19 May 2015 19:39:01 +0200
Content-Transfer-Encoding: 7bit
Message-Id: <611EB56D-2A2D-4307-969F-6E7BEAEB597C@holtmann.org>
References: <4189396.LhxDXkIPfr@wuerfel>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Alexander Aring <alex.aring@gmail.com>, "David S. Miller" <davem@davemloft.net>, linux-wpan@vger.kernel.org, netdev <netdev@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arm-kernel@lists.infradead.org

Hi Arnd,

> The mac802154 subsystem uses functions from the crypto layer and correctly
> selects the individual crypto algorithms, but fails to build when the
> crypto layer is disabled altogether:
> 
> crypto/built-in.o: In function `crypto_ctr_free':
> :(.text+0x80): undefined reference to `crypto_drop_spawn'
> crypto/built-in.o: In function `crypto_rfc3686_free':
> :(.text+0xac): undefined reference to `crypto_drop_spawn'
> crypto/built-in.o: In function `crypto_ctr_crypt':
> :(.text+0x2f0): undefined reference to `blkcipher_walk_virt_block'
> :(.text+0x2f8): undefined reference to `crypto_inc'
> 
> To solve that, this patch also selects the core crypto code,
> like all other users of that code do.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

patch has been applied to bluetooth-next tree.

Regards

Marcel

