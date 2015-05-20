Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f43.google.com ([74.125.82.43]:34253 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751213AbbETKm1 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 20 May 2015 06:42:27 -0400
Received: by wghq2 with SMTP id q2so48211381wgh.1
        for <linux-wpan@vger.kernel.org>; Wed, 20 May 2015 03:42:25 -0700 (PDT)
Date: Wed, 20 May 2015 12:42:23 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH 6/8] ieee802154 socket: No need to check for
 ARPHRD_IEEE802154 in raw_bind().
Message-ID: <20150520104222.GH3978@omega>
References: <cover.1432064518.git.buytenh@wantstofly.org>
 <20150519195015.GR11014@wantstofly.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20150519195015.GR11014@wantstofly.org>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Lennert Buytenhek <buytenh@wantstofly.org>
Cc: linux-wpan@vger.kernel.org

On Tue, May 19, 2015 at 10:50:15PM +0300, Lennert Buytenhek wrote:
> ieee802154_get_dev() only returns devices that have dev->type ==
> ARPHRD_IEEE802154, therefore, there is no need to check this again
> in raw_bind().
> 
> Signed-off-by: Lennert Buytenhek <buytenh@wantstofly.org>

Acked-by: Alexander Aring <alex.aring@gmail.com>
