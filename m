Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f50.google.com ([74.125.82.50]:33637 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752804AbbE2GTe (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 29 May 2015 02:19:34 -0400
Received: by wgez8 with SMTP id z8so53911064wge.0
        for <linux-wpan@vger.kernel.org>; Thu, 28 May 2015 23:19:32 -0700 (PDT)
Date: Fri, 29 May 2015 08:19:25 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [RFC bluetooth-next] mac802154: add trace functionality for
 driver ops
Message-ID: <20150529061923.GA1467@omega>
References: <1432715090-23345-1-git-send-email-varkab@cdac.in>
 <20150528082032.GA1114@omega>
 <5567F9C4.5080904@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5567F9C4.5080904@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Varka Bhadram <varkabhadram@gmail.com>
Cc: linux-wpan@vger.kernel.org, Varka Bhadram <varkab@cdac.in>

On Fri, May 29, 2015 at 11:01:48AM +0530, Varka Bhadram wrote:
> Hi Alex,
> 
> On 05/28/2015 01:50 PM, Alexander Aring wrote:
> 
> >Hi,
> >
> >I did not test yet, but found some review things.
> 
> Please test it.
> 
> >On Wed, May 27, 2015 at 01:54:50PM +0530, Varka Bhadram wrote:
> >...
> >>+		__field(bool, mode)
> >>+	),
> >>+	TP_fast_assign(
> >>+		LOCAL_ASSIGN;
> >>+		__entry->mode = mode;
> >>+	),
> >>+	TP_printk(LOCAL_PR_FMT ", lbt mode: %s", LOCAL_PR_ARG,
> >>+		  BOOL_TO_STR(__entry->mode))
> >>+);
> >>+
> >>+TRACE_EVENT(802154_drv_set_short_addr,
> >>+	TP_PROTO(struct ieee802154_local *local, __le16 short_addr),
> >>+	TP_ARGS(local, short_addr),
> >>+	TP_STRUCT__entry(
> >>+		LOCAL_ENTRY
> >>+		__field(__le16, short_addr)
> >>+	),
> >>+	TP_fast_assign(
> >>+		LOCAL_ASSIGN;
> >>+		__entry->short_addr = short_addr;
> >>+	),
> >>+	TP_printk(LOCAL_PR_FMT ", sa: 0x%04x", LOCAL_PR_ARG,
> >>+		  __entry->short_addr)
> >care about byteorder here. you need cpu_to_le16 in the format string,
> >please.
> >
> >

meant s/cpu_to_le16/le16_to_cpu/

- Alex

