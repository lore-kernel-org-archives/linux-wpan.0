Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from senator.holtmann.net ([87.106.208.187]:37655 "EHLO
	mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750991AbbJBVfm (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 2 Oct 2015 17:35:42 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.0 \(3094\))
Subject: Re: [patch] nl802154: Missing return in nl802154_add_llsec_key()
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20151002074729.GA16768@mwanda>
Date: Fri, 2 Oct 2015 23:35:34 +0200
Content-Transfer-Encoding: 7bit
Message-Id: <A78598D3-3A0B-4D38-A665-509FF4D6E42A@holtmann.org>
References: <20151002074729.GA16768@mwanda>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Alexander Aring <alex.aring@gmail.com>, linux-wpan@vger.kernel.org, kernel-janitors@vger.kernel.org

Hi Dan,

> There was a missing return here so it meant that often
> ieee802154_llsec_parse_key_id() was not called.
> 
> Fixes: a26c5fd7622d ('nl802154: add support for security layer')
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

patch has been applied to bluetooth-next tree.

Regards

Marcel

