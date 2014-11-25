Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:34681 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753293AbaKYNTQ (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 25 Nov 2014 08:19:16 -0500
Received: by mail-wi0-f171.google.com with SMTP id bs8so9082720wib.10
        for <linux-wpan@vger.kernel.org>; Tue, 25 Nov 2014 05:19:15 -0800 (PST)
Date: Tue, 25 Nov 2014 14:19:12 +0100
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH bluetooth-next] mac802154: remove unnecessary if statement
Message-ID: <20141125131909.GB12678@omega>
References: <1416913483-19314-1-git-send-email-varkab@cdac.in>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1416913483-19314-1-git-send-email-varkab@cdac.in>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Varka Bhadram <varkabhadram@gmail.com>
Cc: linux-wpan@vger.kernel.org, Varka Bhadram <varkab@cdac.in>

On Tue, Nov 25, 2014 at 04:34:43PM +0530, Varka Bhadram wrote:
> Removes unnecessary if statement check for net device. Error check performed
> after alloc_netdev().
> 
> 	ndev = alloc_netdev(sizeof(*sdata) + local->hw.vif_data_size, name,
> 			    NET_NAME_UNKNOWN, ieee802154_if_setup);
>         if (!ndev)
>                 return ERR_PTR(-ENOMEM);
> 	..
> 
> Signed-off-by: Varka Bhadram <varkab@cdac.in>

Acked-by: Alexander Aring <alex.aring@gmail.com>
