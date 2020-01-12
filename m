Return-Path: <SRS0=vvoQ=3C=vger.kernel.org=linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12121C33CAE
	for <linux-wpan@archiver.kernel.org>; Mon, 13 Jan 2020 07:31:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6E88207FF
	for <linux-wpan@archiver.kernel.org>; Mon, 13 Jan 2020 07:31:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728809AbgAMHbo (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Mon, 13 Jan 2020 02:31:44 -0500
Received: from mail02.vodafone.es ([217.130.24.81]:59058 "EHLO
        mail02.vodafone.es" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728646AbgAMHbm (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 13 Jan 2020 02:31:42 -0500
IronPort-SDR: leMqbdFVs3BD53Zbc/c5r4RyK5GurYV1A9V5rMMGdX8Bw0b7Tdr8KhdPdAVIL9y1E41HmEdRoL
 yHjRHIR6kbSQ==
IronPort-PHdr: =?us-ascii?q?9a23=3AjRp4BxUnaQjZrnUGbgWYYMOCLQDV8LGtZVwlr6?=
 =?us-ascii?q?E/grcLSJyIuqrYbB2Et8tkgFKBZ4jH8fUM07OQ7/m7HzZesN3Y6ShKWacPfi?=
 =?us-ascii?q?dNsd8RkQ0kDZzNImzAB9muURYHGt9fXkRu5XCxPBsdMs//Y1rPvi/6tmZKSV?=
 =?us-ascii?q?3wOgVvO+v6BJPZgdip2OCu4Z3TZBhDiCagbb9oIxi6sAvcutMIjYZjLqs9xQ?=
 =?us-ascii?q?bFrmZUd+9L2W5mOFWfkgrm6Myt5pBj6SNQu/wg985ET6r3erkzQKJbAjo7LW?=
 =?us-ascii?q?07/dXnuhbfQwSB4HscSXgWnQFTAwfZ9hH6X4z+vTX8u+FgxSSVJ8z2TbQzWT?=
 =?us-ascii?q?S/86dmTQLjhSkbOzIl9mzcl8p8gKVGrh29vRN/xo7VbJiLOfp5ZKPdZdQaRX?=
 =?us-ascii?q?BbUcZNSSNNG52zb40WA+cdIeZYs5PyqEcOrRSgAAmjGuXvyiNRinDo2602yu?=
 =?us-ascii?q?MvEQbA3AM+H9MCqWrbrNPoP6sWX+250LXEwTDFYvhL2zny9ZLIfwgvr/+MR7?=
 =?us-ascii?q?J+b8nfx1QgGAzZgVudspDlMjGJ2egRr2SX8/RsWOSygGAnsQFxpT2vy982hI?=
 =?us-ascii?q?bXmoIa1ErE/jh5z4YyI924R1NwbNm8EJROqyGVKZF2Q80lQ2FutyY30b0GuY?=
 =?us-ascii?q?WgcycW0pgo2xnfa/mdf4iI4RLuTeCcKip7inJ9YL+zmQu+/Eq6xuHhWMS4zE?=
 =?us-ascii?q?xGojRKn9XWuH0A1xre4dWdRPRn5EeuwzOP2hjW6uFDPE87i7LWK4Ukwr4sjp?=
 =?us-ascii?q?oTtlnDHjPulEX2kqCWckIk9/Ct6+v9Y7XmooWcOJFwig3iPakigNK/AeMlPQ?=
 =?us-ascii?q?cUUWib/uK826P58ULnW7VGlvw2kq/Hv5DGPckXuLO1Dg1P3oo+5RuzEy2q3M?=
 =?us-ascii?q?oXkHUdIl9IeAqLj43zNFHPJPD4A+2/g1OpkDpz3/DJIKHhDYvXLnnNl7fhe7?=
 =?us-ascii?q?l95lVcyAoo1t9Q+4hYBa0GIPL2QEPxtN/YAgcjMwOo2+bnFMl91oQGVGKLA6?=
 =?us-ascii?q?+ZNr7SsFCR6uMhO+mDfokVtS3jK/gq+fHul2U1mVwDcqmz25sYdnS4Eu5hI0?=
 =?us-ascii?q?WDbnq/yusGRGMLuBcuCfPygVuqTzFefTCxUrg66zV9D5ipXr3OXoS8vLvU5C?=
 =?us-ascii?q?qnE4ceWWdABRjYCXr0ep+bXPEDaCGSOcVqujMBXLmlDYQm0Ef9mhX9zu9fI/?=
 =?us-ascii?q?bZ4GUnspTsnIxt6vHejw418zNcD9+X2CeGSGQynmBeFGx+57x2vUEokwTL6q?=
 =?us-ascii?q?N/mfENToQL6g=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2EGEgDeGxxeeiMYgtkUBjMYGgEBAQE?=
 =?us-ascii?q?BAQEBAQMBAQEBEQEBAQICAQEBAYF7AgEBFwEBgS6BTVIgEpNQgU0fg0OLY4E?=
 =?us-ascii?q?Agx4VhggTDIFbDQEBAQEBGxoCAQGEQE4BF4ESJDoEDQIDDQEBBQEBAQEBBQQ?=
 =?us-ascii?q?BAQIQAQEJDQsEK4VKgh0MHgEEAQEBAQMDAwEBDAGDXQcZDzlKTAEOAVOFTwE?=
 =?us-ascii?q?BM4UilzsBhASJAA0NAoUdgkcECoEJgRojgTYBjBgagUE/gSMhgisIAYIBgn8?=
 =?us-ascii?q?BEgFsgkiCWQSNQhIhgQeIKZgXgkEEdolMjAKCNwEPiAGEMQMQgkUPgQmIA4R?=
 =?us-ascii?q?OgX2jN1eBDA16cTMagiYagSBPGA2WSECBFhACT4kugjIBAQ?=
X-IPAS-Result: =?us-ascii?q?A2EGEgDeGxxeeiMYgtkUBjMYGgEBAQEBAQEBAQMBAQEBE?=
 =?us-ascii?q?QEBAQICAQEBAYF7AgEBFwEBgS6BTVIgEpNQgU0fg0OLY4EAgx4VhggTDIFbD?=
 =?us-ascii?q?QEBAQEBGxoCAQGEQE4BF4ESJDoEDQIDDQEBBQEBAQEBBQQBAQIQAQEJDQsEK?=
 =?us-ascii?q?4VKgh0MHgEEAQEBAQMDAwEBDAGDXQcZDzlKTAEOAVOFTwEBM4UilzsBhASJA?=
 =?us-ascii?q?A0NAoUdgkcECoEJgRojgTYBjBgagUE/gSMhgisIAYIBgn8BEgFsgkiCWQSNQ?=
 =?us-ascii?q?hIhgQeIKZgXgkEEdolMjAKCNwEPiAGEMQMQgkUPgQmIA4ROgX2jN1eBDA16c?=
 =?us-ascii?q?TMagiYagSBPGA2WSECBFhACT4kugjIBAQ?=
X-IronPort-AV: E=Sophos;i="5.69,428,1571695200"; 
   d="scan'208";a="323892915"
Received: from mailrel04.vodafone.es ([217.130.24.35])
  by mail02.vodafone.es with ESMTP; 13 Jan 2020 08:31:40 +0100
Received: (qmail 24632 invoked from network); 12 Jan 2020 05:00:22 -0000
Received: from unknown (HELO 192.168.1.3) (quesosbelda@[217.217.179.17])
          (envelope-sender <peterwong@hsbc.com.hk>)
          by mailrel04.vodafone.es (qmail-ldap-1.03) with SMTP
          for <linux-wpan@vger.kernel.org>; 12 Jan 2020 05:00:22 -0000
Date:   Sun, 12 Jan 2020 06:00:20 +0100 (CET)
From:   Peter Wong <peterwong@hsbc.com.hk>
Reply-To: Peter Wong <peterwonghkhsbc@gmail.com>
To:     linux-wpan@vger.kernel.org
Message-ID: <10305085.460861.1578805222391.JavaMail.cash@217.130.24.55>
Subject: Investment opportunity
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Greetings,
Please read the attached investment proposal and reply for more details.
Are you interested in loan?
Sincerely: Peter Wong




----------------------------------------------------
This email was sent by the shareware version of Postman Professional.

