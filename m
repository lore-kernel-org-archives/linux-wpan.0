Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-io0-f195.google.com ([209.85.223.195]:39903 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752380AbeFEVRS (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Tue, 5 Jun 2018 17:17:18 -0400
Received: by mail-io0-f195.google.com with SMTP id f1-v6so5126019ioh.6
        for <linux-wpan@vger.kernel.org>; Tue, 05 Jun 2018 14:17:18 -0700 (PDT)
Date: Tue, 5 Jun 2018 17:17:11 -0400
From: Alexander Aring <aring@mojatatu.com>
Subject: Re: [PATCH RFC wpan] net: 6lowpan: fix reserved space for single
 frames
Message-ID: <20180605211711.rwbtvjupu435ovev@x220t>
References: <20180601155843.29724-1-aring@mojatatu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180601155843.29724-1-aring@mojatatu.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: stefan@osg.samsung.com
Cc: linux-wpan@vger.kernel.org, kernel@mojatatu.com

Hi,

On Fri, Jun 01, 2018 at 11:58:43AM -0400, Alexander Aring wrote:
> This patch fixes patch add handling to take care tail and headroom for
> single 6lowpan frames. We need to be sure we have a skb with the right
> head and tailroom for single frames. This patch do it by using
> skb_copy_expand().
> 
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=195059
> Signed-off-by: Alexander Aring <aring@mojatatu.com>

drop this, I found the bug in IPv6 (I suppose).

I will do a proper patch with additional Reported-by tag to David.

- Alex
