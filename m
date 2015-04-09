Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:36907 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755104AbbDIJOm (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 9 Apr 2015 05:14:42 -0400
Received: by wiaa2 with SMTP id a2so90178190wia.0
        for <linux-wpan@vger.kernel.org>; Thu, 09 Apr 2015 02:14:41 -0700 (PDT)
Date: Thu, 9 Apr 2015 11:14:37 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH bluetooth-next v2] mac802154: fix transmission power
 datatype
Message-ID: <20150409091434.GB1261@omega>
References: <1428567911-1857-1-git-send-email-varkab@cdac.in>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1428567911-1857-1-git-send-email-varkab@cdac.in>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Varka Bhadram <varkabhadram@gmail.com>
Cc: linux-wpan@vger.kernel.org, Varka Bhadram <varkab@cdac.in>

Hi Varka,

On Thu, Apr 09, 2015 at 01:55:11PM +0530, Varka Bhadram wrote:
> Netlink attribute for the power is s8. But for the driver level
> operations we are collection power level value into integer.
> It has to be change to s8 from int.
> 
> Signed-off-by: Varka Bhadram <varkab@cdac.in>

Acked-by: Alexander Aring <alex.aring@gmail.com>

Thanks.

- Alex
