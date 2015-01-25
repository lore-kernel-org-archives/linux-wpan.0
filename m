Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:49767 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751904AbbAYPCZ (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sun, 25 Jan 2015 10:02:25 -0500
Received: by mail-wi0-f179.google.com with SMTP id l15so5414514wiw.0
        for <linux-wpan@vger.kernel.org>; Sun, 25 Jan 2015 07:02:23 -0800 (PST)
Date: Sun, 25 Jan 2015 16:02:12 +0100
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH wpan-misc] website: fix name for Table:2
Message-ID: <20150125150209.GA1059@omega>
References: <1422001526-14559-1-git-send-email-varkab@cdac.in>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1422001526-14559-1-git-send-email-varkab@cdac.in>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Varka Bhadram <varkabhadram@gmail.com>
Cc: linux-wpan@vger.kernel.org

Hi Varka,

On Fri, Jan 23, 2015 at 01:55:26PM +0530, Varka Bhadram wrote:
> 
> Signed-off-by: Varka Bhadram <varkab@cdac.in>
> ---
>  website/index.txt |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/website/index.txt b/website/index.txt
> index 4ccb218..c9e58d2 100644
> --- a/website/index.txt
> +++ b/website/index.txt
> @@ -116,7 +116,7 @@ Currently a rework of 802.15.4 subsystem is in progress.
>  
>  The rework will contains a new netlink API and a general handling about frame creation and parsing.
>  
> -.Supported 802.15.4 Hardware
> +.Work status
>  [options="header"]
>  |=======================================
>  |Milestone        | Description | state
> -- 
> 1.7.9.5

Applied and regenerated the website.

Thanks.

- Alex
