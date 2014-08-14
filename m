Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:37309 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751243AbaHNISj (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 14 Aug 2014 04:18:39 -0400
Received: by mail-wg0-f44.google.com with SMTP id m15so732290wgh.3
        for <linux-wpan@vger.kernel.org>; Thu, 14 Aug 2014 01:18:37 -0700 (PDT)
Date: Thu, 14 Aug 2014 10:18:32 +0200
From: Alexander Aring <alex.aring@gmail.com>
Message-ID: <20140814081830.GA19852@omega>
References: <1407937595-16415-1-git-send-email-alex.aring@gmail.com>
 <1407937595-16415-13-git-send-email-alex.aring@gmail.com>
 <53EC6DD1.7010306@xsilon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <53EC6DD1.7010306@xsilon.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
Subject: Re: [PATCH wpan-next 12/12] mac802154: rework sdata state change to
 running
To: Martin Townsend <martin.townsend@xsilon.com>
Cc: linux-wpan@vger.kernel.org

On Thu, Aug 14, 2014 at 09:05:37AM +0100, Martin Townsend wrote:
> Looks good, I would think that the mutex is not needed as set_bit and clear_bit are atomic operations??
>

you are right, it's atomic. I will change the commit msg according to
this. I thought it would be locked because it's only read/write when
rtnl lock is hold. This is the current behaviour, but it's not
necessary.

- Alex
