Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from senator.holtmann.net ([87.106.208.187]:47492 "EHLO
	mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752226AbbG3MKA (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 30 Jul 2015 08:10:00 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2102\))
Subject: Re: [PATCH bluetooth-next] mac802154: Fix memory corruption with global deferred transmit state.
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20150721144447.GH20876@wantstofly.org>
Date: Thu, 30 Jul 2015 14:09:57 +0200
Content-Transfer-Encoding: 7bit
Message-Id: <32003B6A-42CD-476C-8FDA-B0291EF75D5A@holtmann.org>
References: <20150721144447.GH20876@wantstofly.org>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Lennert Buytenhek <buytenh@wantstofly.org>
Cc: linux-wpan@vger.kernel.org, Alexander Aring <alex.aring@gmail.com>

Hi Lennert,

> When transmitting a packet via a mac802154 driver that can sleep in
> its transmit function, mac802154 defers the call to the driver's
> transmit function to a per-device workqueue.
> 
> However, mac802154 uses a single global work_struct for this, which
> means that if you have more than one registered mac802154 interface
> in the system, and you transmit on more than one of them at the same
> time, you'll very easily cause memory corruption.
> 
> This patch moves the deferred transmit processing state from global
> variables to struct ieee802154_local, and this seems to fix the memory
> corruption issue.
> 
> Signed-off-by: Lennert Buytenhek <buytenh@wantstofly.org>
> ---
> There were patches for this issue on the mailing list, but it
> doesn't seem that a fix for this issue has been applied yet -- how
> about this?

patch has been applied to bluetooth-next tree.

Regards

Marcel

