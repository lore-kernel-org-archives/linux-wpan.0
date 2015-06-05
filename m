Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:34105 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751474AbbFEMTR (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 5 Jun 2015 08:19:17 -0400
Received: by wibut5 with SMTP id ut5so19304186wib.1
        for <linux-wpan@vger.kernel.org>; Fri, 05 Jun 2015 05:19:16 -0700 (PDT)
Date: Fri, 5 Jun 2015 14:19:13 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH wpan-tools] treewide: replace wireless with wpan
Message-ID: <20150605121912.GC30035@omega>
References: <1433504605-5242-1-git-send-email-alex.aring@gmail.com>
 <55718E7E.1060701@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <55718E7E.1060701@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Varka Bhadram <varkabhadram@gmail.com>
Cc: linux-wpan@vger.kernel.org

On Fri, Jun 05, 2015 at 05:26:46PM +0530, Varka Bhadram wrote:
> Hi,
> 
> On 06/05/2015 05:13 PM, Alexander Aring wrote:
> 
> >This patch replaced several wireless string with wpan. This behaviour
> >was simpled copied from wireless iw tool and it hasn't been renamed to
> >wpan.
> >
> >Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> >---
> >  src/info.c      | 4 ++--
> >  src/interface.c | 2 +-
> >  2 files changed, 3 insertions(+), 3 deletions(-)
> >
> >diff --git a/src/info.c b/src/info.c
> >index 2434bef..8afeeb7 100644
> >--- a/src/info.c
> >+++ b/src/info.c
> >@@ -459,7 +459,7 @@ static int handle_info(struct nl802154_state *state,
> >  }
> >  __COMMAND(NULL, info, "info", NULL, NL802154_CMD_GET_WPAN_PHY, 0, 0, CIB_PHY, handle_info,
> >-	  "Show capabilities for the specified wireless device.", NULL);
> >+	  "Show capabilities for the specified wpan device.", NULL);
> >  TOPLEVEL(list, NULL, NL802154_CMD_GET_WPAN_PHY, NLM_F_DUMP, CIB_NONE, handle_info,
> >-	 "List all wireless devices and their capabilities.");
> >+	 "List all wpan devices and their capabilities.");
> >  TOPLEVEL(phy, NULL, NL802154_CMD_GET_WPAN_PHY, NLM_F_DUMP, CIB_NONE, handle_info, NULL);
> >diff --git a/src/interface.c b/src/interface.c
> >index 647247b..c67077b 100644
> >--- a/src/interface.c
> >+++ b/src/interface.c
> >@@ -252,4 +252,4 @@ static int handle_dev_dump(struct nl802154_state *state,
> >  	return 0;
> >  }
> >  TOPLEVEL(dev, NULL, NL802154_CMD_GET_INTERFACE, NLM_F_DUMP, CIB_NONE, handle_dev_dump,
> >-	 "List all network interfaces for wireless hardware.");
> >+	 "List all network interfaces for wpan hardware.");
> 
> We also have some typo in usage:
> 

send patches. :-)

- Alex
