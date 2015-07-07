Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:36196 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754747AbbGGGji (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 7 Jul 2015 02:39:38 -0400
Received: by widjy10 with SMTP id jy10so179236692wid.1
        for <linux-wpan@vger.kernel.org>; Mon, 06 Jul 2015 23:39:36 -0700 (PDT)
Date: Tue, 7 Jul 2015 08:39:18 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH bluetooth-next 1/2] mac802154: do not export
 ieee802154_rx()
Message-ID: <20150707063917.GA1103@omega>
References: <1436246443-8243-1-git-send-email-varkabhadram@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1436246443-8243-1-git-send-email-varkabhadram@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Varka Bhadram <varkabhadram@gmail.com>
Cc: linux-wpan@vger.kernel.org

Hi,

On Tue, Jul 07, 2015 at 10:50:42AM +0530, Varka Bhadram wrote:
> Right now there are no other users for ieee802154_rx()
> in kernel. So lets remove EXPORT_SYMBOL() for this.
> 
> Also it moves the function prototype from global header
> file to local header file.
> 
> Signed-off-by: Varka Bhadram <varkabhadram@gmail.com>

Acked-by: Alexander Aring <alex.aring@gmail.com>

on the complete serie.

- Alex
