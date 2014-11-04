Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from senator.holtmann.net ([87.106.208.187]:40407 "EHLO
	mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751017AbaKDQpy (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 4 Nov 2014 11:45:54 -0500
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.0 \(1990.1\))
Subject: Re: [patch] ieee802154: || vs && in ieee802154_is_valid_extended_addr()
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20141104085509.GA12954@mwanda>
Date: Tue, 4 Nov 2014 08:45:47 -0800
Content-Transfer-Encoding: 7bit
Message-Id: <6CB0530D-C305-48DE-BF67-4E055B080AA1@holtmann.org>
References: <20141104085509.GA12954@mwanda>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Alexander Aring <alex.aring@gmail.com>, linux-wpan@vger.kernel.org

Hi Dan,

> The ieee802154_is_valid_extended_addr() always returns true because
> there is a typo.  The || should be &&.  Neither 0x0000000000000000ULL
> nor 0xffffffffffffffffULL are valid addresses.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

patch has been applied to bluetooth-next tree.

Regards

Marcel

