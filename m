Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:40252 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751229AbaKDJND (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 4 Nov 2014 04:13:03 -0500
Received: by mail-lb0-f174.google.com with SMTP id z11so8659149lbi.5
        for <linux-wpan@vger.kernel.org>; Tue, 04 Nov 2014 01:13:01 -0800 (PST)
Date: Tue, 4 Nov 2014 10:12:55 +0100
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [patch] ieee802154: || vs && in
 ieee802154_is_valid_extended_addr()
Message-ID: <20141104091252.GA643@omega>
References: <20141104000139.GA23799@omega>
 <20141104085509.GA12954@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20141104085509.GA12954@mwanda>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: linux-wpan@vger.kernel.org

On Tue, Nov 04, 2014 at 11:55:09AM +0300, Dan Carpenter wrote:
> The ieee802154_is_valid_extended_addr() always returns true because
> there is a typo.  The || should be &&.  Neither 0x0000000000000000ULL
> nor 0xffffffffffffffffULL are valid addresses.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Acked-by: Alexander Aring <alex.aring@gmail.com>
