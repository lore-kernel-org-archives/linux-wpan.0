Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4194C77AA;
	Thu,  4 Jun 2026 17:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780594126; cv=none; b=BhE8LLrX38yBQ4AdkvdvqAS5XT3HrAYZcUCMigvfGowzYBHmDz/cIlaClC3lf0tzLhzQihym5kHn+xYr9PGjkNPDo2r3iqhA0hC0sFQcVWbzFiBOysFXOFtJikyO1VaRF8mqg3FK9QNtWFW5ErM2pITW3wAqZINLJagLWW7q/K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780594126; c=relaxed/simple;
	bh=FE/zpAIJ3+uA18zKSazKJm+9T9PyK7kLMINlO/kRdrs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ObaxksVd9+8Wx9/dh41t6UCgH87PT08s/p4FbVtUU5xqlbvVGbo2kLFdbOgSd7YgBrBfLUUT/F+PPQ7bYNBzvUGd3OClmgKI5hzvd/WhX+4ihOogKriB+ddfEUV+Q3HXHoAGCO9HaeklZ1Sa12CoO5pCJJ6UddiEPKCo8O8LZPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hKC1thbz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hKC1thbz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E350A1F00898;
	Thu,  4 Jun 2026 17:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780594125;
	bh=7im0k5oW5XfUrXHH99zBcEKuYwrSW9WmaNTeeDdHU6g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hKC1thbzicUfYEznOZQjP8v3o0MykMvpy8aNDZ2HICZbqfqyuykI/CQKdLpQovnMk
	 g6bO/deQYdXem8HKUhPUuiK44853VxmMdifZRzi+h9YAG1U2v/054Fr/tComocdigm
	 Uc4BfTHo6pPqJig1DsVE8fSpP+/kGtkRA+7toSz0l5S8uC7mQn6v/b8NJHX0Ou0Rsc
	 qJfoOV9Fx6KoLZmOzbYxaepwa6YO2ZjtyI5jZHSv6KcFwNzumi6sUcjZXP2OIaKjCi
	 pQpQYVThxH0ZsiVl9BCRtDOQrv9ifPgpBDoZsrOQFKOlndl3w9XD/9KeCrrjraG8pm
	 mvLF3K39AIZFA==
Date: Thu, 4 Jun 2026 18:28:40 +0100
From: Simon Horman <horms@kernel.org>
To: Robertus Diawan Chris <robertusdchris@gmail.com>
Cc: alex.aring@gmail.com, stefan@datenfreihafen.org,
	miquel.raynal@bootlin.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	skhan@linuxfoundation.org, me@brighamcampbell.com
Subject: Re: [PATCH] mac802154: Prevent overwrite return code in
 mac802154_perform_association()
Message-ID: <20260604172840.GE3920875@horms.kernel.org>
References: <20260602054133.470293-1-robertusdchris@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260602054133.470293-1-robertusdchris@gmail.com>

On Tue, Jun 02, 2026 at 12:41:33PM +0700, Robertus Diawan Chris wrote:
> When assoc_status not equal to IEEE802154_ASSOCIATION_SUCCESSFUL, the
> return value assigned to either "-ERANGE" or "-EPERM" but this return
> value will be overwritten to 0 after exiting the conditional scope.
> So, jump to clear_assoc label to preserve the return value when
> assoc_status not equal to IEEE802154_ASSOCIATION_SUCCESSFUL.
> 
> This is reported by Coverity Scan as "Unused value".
> 
> Fixes: fefd19807fe9 ("mac802154: Handle associating")
> Signed-off-by: Robertus Diawan Chris <robertusdchris@gmail.com>

FTR: An AI generated review of this patch is available on sashiko.dev.
I believe that review can be treated in the context of possible follow-up
and should not effect the progress of this patch.
