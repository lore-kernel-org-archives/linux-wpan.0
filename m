Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:38584 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752007AbbJBKhP (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 2 Oct 2015 06:37:15 -0400
Date: Fri, 2 Oct 2015 12:37:07 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [patch] nl802154: Missing return in nl802154_add_llsec_key()
Message-ID: <20151002103703.GA7896@omega>
References: <20151002071958.GA565@omega>
 <20151002074729.GA16768@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20151002074729.GA16768@mwanda>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: linux-wpan@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>, kernel-janitors@vger.kernel.org

Hi,

On Fri, Oct 02, 2015 at 10:47:29AM +0300, Dan Carpenter wrote:
> There was a missing return here so it meant that often
> ieee802154_llsec_parse_key_id() was not called.
> 
> Fixes: a26c5fd7622d ('nl802154: add support for security layer')
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> 

Acked-by: Alexander Aring <alex.aring@gmail.com>

Thanks.

- Alex
