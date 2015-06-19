Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:33660 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751507AbbFSHso (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 19 Jun 2015 03:48:44 -0400
Received: by wibee9 with SMTP id ee9so1463975wib.0
        for <linux-wpan@vger.kernel.org>; Fri, 19 Jun 2015 00:48:43 -0700 (PDT)
Date: Fri, 19 Jun 2015 09:48:37 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH bluetooth-next] mac802154: fix llsec authentication
 without encryption BUG
Message-ID: <20150619074832.GA867@omega>
References: <1434642901-11646-1-git-send-email-simon.vincent@xsilon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1434642901-11646-1-git-send-email-simon.vincent@xsilon.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Simon Vincent <simon.vincent@xsilon.com>
Cc: linux-wpan@vger.kernel.org, phoebe.buckheister@itwm.fraunhofer.de

On Thu, Jun 18, 2015 at 04:55:01PM +0100, Simon Vincent wrote:
>  802.15.4 security levels 1,2,3 provide data authenticity but
>  no encryption. Currently the llsec implementation hits a BUG() if these modes
>  are used. This is due to the scatterlist length being set to 0 when
>  encryption is not used. This patch fixes this issue.
> 
> Signed-off-by: Simon Vincent <simon.vincent@xsilon.com>

Acked-by: Alexander Aring <alex.aring@gmail.com>
