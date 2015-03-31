Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f53.google.com ([74.125.82.53]:34234 "EHLO
	mail-wg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753423AbbCaSDM (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 31 Mar 2015 14:03:12 -0400
Received: by wgbdm7 with SMTP id dm7so28175108wgb.1
        for <linux-wpan@vger.kernel.org>; Tue, 31 Mar 2015 11:03:11 -0700 (PDT)
Date: Tue, 31 Mar 2015 20:03:05 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH wpan-tools] gitignore: add object files
Message-ID: <20150331180259.GA4348@omega>
References: <1426736478-6140-1-git-send-email-varkab@cdac.in>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1426736478-6140-1-git-send-email-varkab@cdac.in>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Varka Bhadram <varkabhadram@gmail.com>
Cc: linux-wpan@vger.kernel.org, Varka Bhadram <varkab@cdac.in>

Hi Varka,

On Thu, Mar 19, 2015 at 09:11:18AM +0530, Varka Bhadram wrote:
> 
> Signed-off-by: Varka Bhadram <varkab@cdac.in>

thanks. Patch applied to wpan-tools and sorry for the latency.

I think then we don't need to have the object files at [0] anymore.

- Alex

[0] https://github.com/linux-wpan/wpan-tools/blob/master/src/.gitignore
