Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965743822BB
	for <linux-wpan@vger.kernel.org>; Sat, 18 Jul 2026 12:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784377248; cv=pass; b=b8C7SxbZ0b4x+wSV0cNBTQCb+pE9So6eq8wREzMTyy8AO+Az/m0z9OJOopGMSWR2ZEyS4tQ2nbfku31yT545uU9fMor8VuJIQhrS0F2VCt8OUHsI7jM3c0BkSb0rknFqZG0fU93i33pVZToXMHd8sMBIYwJeBPdM5T55aJTnH/c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784377248; c=relaxed/simple;
	bh=SawkhVKH+C/u+ep19YJdq5ABv7YXpG25grrv5K0m2hg=;
	h=In-Reply-To:References:MIME-Version:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LTcY1qJEmvDpB2XLpm+9yBEb9OWLpNYXMe+jL4XjBk4EtDRE2glhxUmnS5Q0KMICcmBGYmafD+QhV/ojprB9E6QCtaBtJNVh22PkIgmgtsWu1YSKxAA/uhqvLPH6YczbHiDAy6/u7awYXvz6J2qsI4Wg4QO0uKrsCzi4T9ZUyFU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rK8tdRhB; arc=pass smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rK8tdRhB"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-668296d0ff3so3235287d50.0
        for <linux-wpan@vger.kernel.org>; Sat, 18 Jul 2026 05:20:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784377245; cv=none;
        d=google.com; s=arc-20260327;
        b=ldqMulgdkBB8nM3INj19o8VW2qzHEPOuXjs6tv+Nk1GTXPHA3dkuc+57dS5UUPr3ny
         /vPYcO/dRTkQsBBM//ZP3edbpR8dkFUlp8d6dvXLeDC5XKGq0z+DUYCTj+LJTGitMhhL
         nROyr+bNtctn6/tOIYe9Spbm4BN7jF31lls494rUEcTOZL1jyhbii1lvBLkrtH1GlHKn
         tK+AvHJVGXfGvlglCXDqpMfkU+9SZ0eSeO1jL0WdC36EC3CgNVMUxj4rsehTPzB5eOhn
         ivyC1OR38CilPfuWjbTsmDdQx6ZlWBBTZ/6xZ03UcXSFx/Uj383t9fq+v2VZuWgdSJzl
         QBdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:references:in-reply-to:dkim-signature;
        bh=SawkhVKH+C/u+ep19YJdq5ABv7YXpG25grrv5K0m2hg=;
        fh=YnLv7ZbmJRZQ02on08okROXogGX67fk6tHHvwMRDhco=;
        b=hRior/DhMcvXO0MMbfF+JA8JzB0IQ9mD5u3shfoDbuEMsMdeh6ftIHEq0UCrhgcRS4
         Lk39Aik8RM+g8IACZcQ2RHKCZw6O6KSClwaOg1x4si3jjAZWr2c75Q7hT22/PdeNPYDq
         cjhFLgZsuvseKeB0jGPElvCSRn0ikB1mNdtg3BNqUXx6xScOZzx6EVlUJ4gZ85Q/1Gpa
         2AsMhyEF6/2hlJ1UI4Lzxotxaf8/PKZdCwtkldWWVbuM+vzx5toX36Z/s6d5y8AyG/81
         nSr9cyTtk4thCr3lMbmfqyyLt4+VFU7GynTLEX6QTGgXQlpmKMXx+MO4XwTKzHLs8oN+
         9UkA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784377245; x=1784982045; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:mime-version:references:in-reply-to:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SawkhVKH+C/u+ep19YJdq5ABv7YXpG25grrv5K0m2hg=;
        b=rK8tdRhBCZGmCjFwHJAZrSAy/R5CWqCNYAHdAaTwvkQP/6RcRYWBprl1VqbNVaUUsS
         jxqchWrCWLdDgbeqautYrKdufPK18YjfO8UYbtQZ4HcVlV8xF5hmCuCryfHh1UCPzCcg
         I1GvuhDz4SBh42AXie4UGRD/insCGoJSLeqfHGLKZk9UkaKgiKBL0BQTUEkl1+cDsfN5
         M61/XKoxywFgAS+dCRlN+namyLs5vQeqhIvGVC/N7Mt9iz8LdHUyS47HjBm+nkWt6M9K
         RRUY7VwpzgGIDXAFj40wJTJDwVLEX22hvA+QrCS5q3xSSxwNcnXQbJAOLV9fVgibWzqN
         Q7hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784377245; x=1784982045;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:mime-version:references:in-reply-to:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SawkhVKH+C/u+ep19YJdq5ABv7YXpG25grrv5K0m2hg=;
        b=c+aYfHeGFKHraWqPgfW1bn6fg6Yn9+iqRttSWD+t4AOWNxjR/77VZna3Hs9eT14d7l
         UsWarXlZMpRHiXQoowOVMhWW1deZ4KVcLXCc/UVMrTJgRQVM+tHrnBVcUR5faYyLshTf
         zbGV9ZAV3SXGIqUktuxm8b9Y+JdOss7xqKvXPEkCj2vYc2CQoNQzV86kBkW4CKqhVVyg
         0kDuyruvmrbr1lS7AREecPUF5u1qe/xsVzwdQcKae69YymSuOmhOueH6XwrTuHlyJc2o
         yT/MLjHFfLXfWDzgW8v+EDSysv7H/gqfpm/IbSCjLj3E9JZQurN1/ZUbAe2iiQd4DCzp
         zlJA==
X-Forwarded-Encrypted: i=1; AHgh+RqdsozI6+SQWrfeIu0pvcCMnTImBHqtxH6X/NfeuRisuHbvOqxxQshO6ovUn3UKRm+YGLh8QhrWZ6l3@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6vSBYmgW5AlzMZONgj1KSfhyH+ueB2H0FIFypNVULRmDx4ysK
	+n0HW8uQM796MhpCyj0FBYiCyjcronnC/BEexsBOh6Tvt/T4PYpZDEcxioV9K6s2O/XsfjPGvtj
	JinLXPO2o/jJjxR+pbD/YYZn03Y0DJ3s=
X-Gm-Gg: AfdE7ckKY1sd18oDotIqIwOuKUXbMID3cJMa6T4L73ghvksVwIPWTHF++sE1NjRgZUO
	gAcJQoJbBpDXRRE/qeYkiLU3XI7385zGlkHIVogNsbOS6tViykbxjWtTl/L6KDvaYXm3J8pxeI6
	TakEUjcvzwWvTw+M5ysgPEjIihe4KPrZp+pgKpDAQNmR54Hew5RDonPqPCyy5nZfbjrkNHJqlv1
	8rBWwuPE8pOZ9ffkGTZL5rX97CSrIdScMR/W7rubH1VfNcgGnGXw2LTCAklWg==
X-Received: by 2002:a05:690e:43c2:b0:667:c01a:4ac5 with SMTP id
 956f58d0204a3-6683bb0c3b6mr1363452d50.38.1784377245608; Sat, 18 Jul 2026
 05:20:45 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Sat, 18 Jul 2026 07:20:44 -0500
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Sat, 18 Jul 2026 07:20:44 -0500
In-Reply-To: <87h5m2g70l.fsf@bootlin.com>
References: <20260709221858.158063-1-devnexen@gmail.com> <87h5m2g70l.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Yousef Alhouseen <alhouseenyousef@gmail.com>
Date: Sat, 18 Jul 2026 07:20:44 -0500
X-Gm-Features: AUfX_mx-LxGT1icCnBbh0h4QeQdJg-IRuavKQPCspOdeBSsqwocWMxKfeD5I5ro
Message-ID: <CAMuQ4bVWGV8Qz7LM1RCVhXJGRV0KVPFXvvhshDEijkv=+aq7Yg@mail.gmail.com>
Subject: Re: [PATCH] ieee802154: hwsim: serialize pib updates to fix double-free
To: miquel.raynal@bootlin.com, devnexen@gmail.com
Cc: alex.aring@gmail.com, stable@vger.kernel.org, 
	syzbot+60332fd095f8bb2946ad@syzkaller.appspotmail.com, 
	stefan@datenfreihafen.org, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	linux-wpan@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Yes. I'll send v2 of my teardown patch with rcu_access_pointer(). It
is separate from David's patch: mine moves the final PIB free after
unregister, while David's serializes concurrent runtime PIB
replacements. I don't think his patch is superseded by mine.

Thanks,
Yousef

On Mon, 13 Jul 2026 18:59:38 +0200, Miquel Raynal
<miquel.raynal@bootlin.com> wrote:
> Hello David,
>
> On 09/07/2026 at 23:18:58 +01, David Carlier <devnexen@gmail.com> wrote:
>
> > hwsim_update_pib() does an unserialized read-swap-free of phy->pib:
> >
> > pib_old =3D rtnl_dereference(phy->pib);
> > ...
> > rcu_assign_pointer(phy->pib, pib);
> > kfree_rcu(pib_old, rcu);
> >
> > It assumes the RTNL is held, but ->set_channel is not always called
> > under it: the mac802154 scan worker changes channels via
> > drv_set_channel() without the RTNL. Such an update can race an
> > RTNL-held one on the same phy; both read the same pib_old and both
> > kfree_rcu() it, double-freeing the object. With SLUB percpu sheaves
> > batching kfree_rcu(), this surfaces as a KASAN invalid-free in
> > rcu_free_sheaf().
> >
> > struct hwsim_phy has no lock for pib. Add one and make the swap atomic
> > with rcu_replace_pointer() under it, dropping the misleading
> > rtnl_dereference().
> >
> > Reported-by: syzbot+60332fd095f8bb2946ad@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=3D60332fd095f8bb2946ad
> > Fixes: f25da51fdc38 ("ieee802154: hwsim: add replacement for fakelb")
> > Signed-off-by: David Carlier <devnexen@gmail.com>
> > Cc: <stable@vger.kernel.org>
>
> Thank you for the patch, but I think Yousef already provided a similar
> patch:
>
> https://lore.kernel.org/all/20260627235805.17310-1-alhouseenyousef@gmail.=
com/
>
> Yousef, can you confirm you will send v2 soon?
>
> Thanks,
> Miqu=C3=A8l
