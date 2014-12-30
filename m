Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from senator.holtmann.net ([87.106.208.187]:50844 "EHLO
	mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751374AbaL3GRp (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 30 Dec 2014 01:17:45 -0500
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Subject: Re: [PATCH bluetooth-next 0/3] Fixes and cleanup for CC2520
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1419569020-5410-1-git-send-email-varkab@cdac.in>
Date: Mon, 29 Dec 2014 22:17:40 -0800
Content-Transfer-Encoding: 7bit
Message-Id: <4A7EA6DD-461D-4681-8FAA-2231796BC257@holtmann.org>
References: <1419569020-5410-1-git-send-email-varkab@cdac.in>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Varka Bhadram <varkabhadram@gmail.com>
Cc: linux-wpan@vger.kernel.org, Alexander Aring <alex.aring@gmail.com>, Varka Bhadram <varkab@cdac.in>

Hi Varka,

> This series will introduce some cleanup code and fix for having
> zero perm_extended_addr address.
> 
> Varka Bhadram (3):
>  cc2520: use devm_kzalloc(.., sizeof(*pointer), ..) pattern
>  cc2520: remove 'ret' goto label
>  cc2520: fix zero perm_extended_addr address
> 
> drivers/net/ieee802154/cc2520.c |   18 ++++++------------
> 1 file changed, 6 insertions(+), 12 deletions(-)

all 3 patches have been applied to bluetooth-next tree.

Regards

Marcel

